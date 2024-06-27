import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/core/ui/custom_icon_button.dart';
import 'package:todo_list/config/theme/app_colors.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/todo_tile/swipe_delete_background.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/todo_tile/swipe_done_background.dart';
import 'package:todo_list/features/todo/presentation/common/dialog_manager.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool reached = false;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.todo.id),
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.3,
        DismissDirection.endToStart: 0.3,
      },
      onUpdate: (details) => _handleUpdate(details),
      confirmDismiss: (direction) => _handleDismiss(direction, context),
      background: DismissDoneBackground(
        todo: widget.todo,
        reached: reached,
        progress: progress,
      ),
      secondaryBackground: DismissDeleteBackground(
        reached: reached,
        progress: progress,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                right: 12,
                bottom: 12,
                left: 16,
              ),
              child: switch (widget.todo.done!) {
                true => const Icon(
                    Icons.check_box,
                    color: AppColors.green,
                  ),
                false => switch (widget.todo.priority) {
                    TodoPriority.high => Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            color: AppColors.red.withOpacity(0.16),
                          ),
                          const Icon(
                            Icons.check_box_outline_blank_rounded,
                            color: AppColors.red,
                          ),
                        ],
                      ),
                    _ => Icon(
                        Icons.check_box_outline_blank,
                        color: Theme.of(context).dividerColor,
                      ),
                  },
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!widget.todo.done!)
                          switch (widget.todo.priority) {
                            TodoPriority.high => Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/priority/high.svg',
                                  ),
                                  const SizedBox(width: 3),
                                ],
                              ),
                            TodoPriority.low => Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/priority/low.svg'),
                                  const SizedBox(width: 3),
                                ],
                              ),
                            TodoPriority.none => const SizedBox.shrink(),
                          },
                        Expanded(
                          child: Text(
                            widget.todo.content!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: switch (widget.todo.done!) {
                                    true =>
                                      Theme.of(context).colorScheme.tertiary,
                                    false => null,
                                  },
                                  decoration: switch (widget.todo.done!) {
                                    true => TextDecoration.lineThrough,
                                    false => TextDecoration.none,
                                  },
                                ),
                          ),
                        ),
                      ],
                    ),
                    if (widget.todo.deadline != null)
                      Column(
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            FormattingHelper.formatDate(widget.todo.deadline!),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            CustomIconButton(
              padding: const EdgeInsets.only(
                top: 12,
                right: 16,
                bottom: 12,
                left: 12,
              ),
              icon: Icons.info_outline,
              onPressed: () => Navigator.of(context).pushNamed(
                '/todo',
                arguments: EditTodo(todo: widget.todo),
              ),
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }

  void _handleUpdate(DismissUpdateDetails details) {
    setState(() {
      progress = details.progress;
      if (details.reached) {
        if (!reached) {
          reached = true;
        }
      } else {
        if (reached) {
          reached = false;
        }
      }
    });
  }

  Future<bool> _handleDismiss(
      DismissDirection direction, BuildContext context) async {
    final bloc = context.read<TodoListBloc>();
    final todo = widget.todo;
    if (direction == DismissDirection.startToEnd) {
      bloc.add(UpdateTodoEvent(widget.todo.copyWith(done: !todo.done!)));
      Log.i(
          'changed todo (id ${todo.id}) completeness status to ${!todo.done!}');
      return false;
    } else if (direction == DismissDirection.endToStart) {
      final result =
          await DialogManager.showDeleteConfirmationDialog(context, todo);
      if (result != null && result) {
        bloc.add(DeleteTodoEvent(widget.todo.id));
      }
      return result ?? false;
    }
    return false;
  }
}
