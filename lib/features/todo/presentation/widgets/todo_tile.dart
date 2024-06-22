import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/common/ui/custom_icon_button.dart';
import 'package:todo_list/config/theme/app_colors.dart';
import 'package:todo_list/features/todo/domain/todo.dart';
import 'package:todo_list/features/todo/presentation/controller/todo_controller.dart';
import 'package:todo_list/features/todo/presentation/pages/new_todo_screen.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_action.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_result.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({
    super.key,
    required this.todo,
    required this.todoBloc,
  });

  final Todo todo;
  final TodoController todoBloc;

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
          todo: widget.todo, reached: reached, progress: progress),
      secondaryBackground:
          _DeleteBackground(reached: reached, progress: progress),
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
            child: switch (widget.todo.isDone!) {
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
                    children: [
                      if (!widget.todo.isDone!)
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
                                    color: switch (widget.todo.isDone!) {
                                      true =>
                                        Theme.of(context).colorScheme.tertiary,
                                      false => null,
                                    },
                                    decoration: switch (widget.todo.isDone!) {
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
                          widget.todo.deadline!.toIso8601String(),
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
            onPressed: () async {
              await _editTodo(context);
            },
            color: Theme.of(context).colorScheme.tertiary,
          ),
          // IconButton(
          // padding: EdgeInsets.zero,
          //   constraints: const BoxConstraints(),
          //   onPressed: () async {
          //     await _editTodo(context);
          //   },
          //   icon: Icon(
          //     Icons.info_outline,
          //     color: Theme.of(context).colorScheme.tertiary,
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<bool> _handleDismiss(
      DismissDirection direction, BuildContext context) async {
    if (direction == DismissDirection.startToEnd) {
      widget.todoBloc.update(widget.todo.copyWith(
        id: widget.todo.id,
        content: widget.todo.content,
        isDone: !widget.todo.isDone!,
        deadline: widget.todo.deadline,
        priority: widget.todo.priority,
      ));
      return false;
    } else if (direction == DismissDirection.endToStart) {
      final shouldDelete = await _showConfirmationDialog(context);
      if (shouldDelete) {
        widget.todoBloc.delete(widget.todo.id);
      }
      return shouldDelete;
    }
    return false;
  }

  Future<void> _editTodo(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewTodoScreen(
        action: EditTodo(
          todo: widget.todo,
        ),
      ),
    ));
    if (result is EditedTodo) {
      final resultTodo = result.todo;
      if (resultTodo != null) {
        widget.todoBloc.update(
          widget.todo.copyWith(
            id: widget.todo.id,
            content: resultTodo.content,
            priority: resultTodo.priority,
            deadline: resultTodo.deadline,
          ),
        );
      }
    } else if (result is DeletedTodo) {
      widget.todoBloc.delete(widget.todo.id);
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Уверены?'),
            content: const Text('Хотите удалить это дело?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('НЕТ'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('ДА'),
              ),
            ],
          ),
        ) ??
        false;
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
            right: reached ? 30 * (10 * progress) : (24 * (4 * progress))),
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
      color: switch (todo.isDone!) {
        true => Theme.of(context).dividerColor,
        false => AppColors.green,
      },
      alignment: Alignment.centerLeft,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 50),
        padding: EdgeInsets.only(
            left: reached ? 30 * (10 * progress) : (24 * (4 * progress))),
        child: Icon(
          todo.isDone! ? Icons.close_rounded : Icons.check,
          color: AppColors.white,
        ),
      ),
    );
  }
}
