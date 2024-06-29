import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/core/extensions/build_context_extension.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/core/ui/custom_card.dart';
import 'package:todo_list/core/ui/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';
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
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        final isBeingProcessed = state is TodoOperationBeingPerformed &&
            state.todoToBeMutated.id == widget.todo.id;
        return AbsorbPointer(
          absorbing: isBeingProcessed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButtonBase(
              shrinkFactor: 0.95,
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.of(context).pushNamed(
                '/todo',
                arguments: EditTodo(todo: widget.todo),
              ),
              child: CustomCard.shimmer(
                enabled: isBeingProcessed,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Dismissible(
                    key: ValueKey(widget.todo.id),
                    dismissThresholds: const {
                      DismissDirection.startToEnd: 0.3,
                      DismissDirection.endToStart: 0.3,
                    },
                    onUpdate: (details) =>
                        !isBeingProcessed ? _handleDragUpdate(details) : null,
                    confirmDismiss: (direction) =>
                        _handleDismiss(direction, context),
                    background: DismissDoneBackground(
                      todo: widget.todo,
                      reached: reached,
                      progress: progress,
                    ),
                    secondaryBackground: DismissDeleteBackground(
                      reached: reached,
                      progress: progress,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12,
                                right: 12,
                                bottom: 12,
                                left: 16,
                              ),
                              child: switch (widget.todo.done) {
                                true => Icon(
                                    Icons.check_box,
                                    color: context.customColors.green,
                                  ),
                                false => switch (widget.todo.importance) {
                                    Importance.important => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            color: context.customColors.red
                                                .withOpacity(0.16),
                                          ),
                                          Icon(
                                            Icons
                                                .check_box_outline_blank_rounded,
                                            color: context.customColors.red,
                                          ),
                                        ],
                                      ),
                                    _ => Icon(
                                        Icons.check_box_outline_blank,
                                        color: context.dividerColor,
                                      ),
                                  },
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (!widget.todo.done)
                                          switch (widget.todo.importance) {
                                            Importance.important => Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/priority/high.svg',
                                                  ),
                                                  const SizedBox(width: 3),
                                                ],
                                              ),
                                            Importance.low => Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/icons/priority/low.svg'),
                                                  const SizedBox(width: 3),
                                                ],
                                              ),
                                            Importance.basic =>
                                              const SizedBox.shrink(),
                                          },
                                        Expanded(
                                          child: Text(
                                            widget.todo.text,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: context.textTheme.bodyMedium!
                                                .copyWith(
                                              color: switch (widget.todo.done) {
                                                true =>
                                                  context.colorScheme.tertiary,
                                                false => null,
                                              },
                                              decoration: switch (
                                                  widget.todo.done) {
                                                true =>
                                                  TextDecoration.lineThrough,
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
                                            FormattingHelper.formatDate(
                                                widget.todo.deadline!),
                                            style: context
                                                .textTheme.labelMedium!
                                                .copyWith(
                                              color:
                                                  context.colorScheme.tertiary,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleDragUpdate(DismissUpdateDetails details) {
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
      bloc.add(
        UpdateTodoEvent(
          todo.copyWithEdit(
            done: !todo.done,
            changedAt: DateTime.now(),
            deadline: todo.deadline,
            color: todo.color,
          ),
        ),
      );
      Log.i('changed todo ${todo.id} completeness status to ${!todo.done}');
      return false;
    } else if (direction == DismissDirection.endToStart) {
      final result =
          await DialogManager.showDeleteConfirmationDialog(context, todo);
      if (result != null && result) {
        bloc.add(DeleteTodoEvent(widget.todo));
      }
      return result ?? false;
    }
    return false;
  }
}
