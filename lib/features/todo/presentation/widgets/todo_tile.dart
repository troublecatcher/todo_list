import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/core/ui/custom_icon_button.dart';
import 'package:todo_list/config/theme/app_colors.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/utility/dialog_manager.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_action.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_result.dart';

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
      key: ValueKey(widget.todo),
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.3,
        DismissDirection.endToStart: 0.3,
      },
      onUpdate: (details) {
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
      },
      confirmDismiss: (direction) async =>
          await _handleDismiss(direction, context),
      background: _StatusChangeBackground(
        todo: widget.todo,
        reached: reached,
        progress: progress,
      ),
      secondaryBackground: _DeleteBackground(
        reached: reached,
        progress: progress,
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
            onPressed: () async => await _editTodo(context),
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ],
      ),
    );
  }

  Future<bool> _handleDismiss(
      DismissDirection direction, BuildContext context) async {
    if (direction == DismissDirection.startToEnd) {
      final todo = widget.todo;
      context.read<TodoBloc>().add(
            UpdateTodoEvent(
              widget.todo.copyWith(done: !todo.done!),
            ),
          );
      Log.i(
          'changed todo (id ${todo.id}) completeness status to ${!todo.done!}');
      return false;
    } else if (direction == DismissDirection.endToStart) {
      Log.i('prompted to delete todo (id ${widget.todo.id})');
      final bloc = context.read<TodoBloc>();
      final result = await DialogManager.showDeleteConfirmationDialog(context);
      if (result != null && result) {
        bloc.add(DeleteTodoEvent(widget.todo.id));
      } else {
        Log.i('rejected to delete todo (id ${widget.todo.id})');
      }
      return result ?? false;
    }
    return false;
  }

  Future<void> _editTodo(BuildContext context) async {
    final bloc = context.read<TodoBloc>();
    final result = await Navigator.of(context).pushNamed(
      '/todo',
      arguments: EditTodo(todo: widget.todo),
    ) as TodoResult?;
    if (result is EditedTodo) {
      final resultTodo = result.todo;
      if (resultTodo != null) {
        bloc.add(
          UpdateTodoEvent(
            widget.todo.copyWith(
              id: resultTodo.id,
              content: resultTodo.content,
              done: resultTodo.done!,
              deadline: resultTodo.deadline,
              priority: resultTodo.priority,
            ),
          ),
        );
      }
    } else if (result is DeletedTodo) {
      bloc.add(DeleteTodoEvent(widget.todo.id));
    }
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground({
    required this.reached,
    required this.progress,
  });

  final bool reached;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.red,
      alignment: Alignment.centerRight,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 50),
        padding: EdgeInsets.only(
            right: reached
                ? MediaQuery.of(context).size.width / 15 * (10 * progress)
                : (24 * (4 * progress))),
        child: const Icon(Icons.delete, color: AppColors.white),
      ),
    );
  }
}

class _StatusChangeBackground extends StatelessWidget {
  final Todo todo;
  final bool reached;
  final double progress;

  const _StatusChangeBackground({
    required this.todo,
    required this.reached,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: switch (todo.done!) {
        true => Theme.of(context).dividerColor,
        false => AppColors.green,
      },
      alignment: Alignment.centerLeft,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 50),
        padding: EdgeInsets.only(
            left: reached
                ? MediaQuery.of(context).size.width / 15 * (10 * progress)
                : (24 * (4 * progress))),
        child: Icon(
          todo.done! ? Icons.close_rounded : Icons.check,
          color: AppColors.white,
        ),
      ),
    );
  }
}
