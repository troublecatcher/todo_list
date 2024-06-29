import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/core/ui/custom_card.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/common/cubit/todo_operation_cubit.dart';
import 'package:todo_list/features/todo/presentation/common/cubit/todo_operation_state.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/components/clickable_checkbox.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/components/swipe_delete_background.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/components/swipe_done_background.dart';
import 'package:todo_list/features/todo/presentation/common/dialog_manager.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/components/todo_content.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/components/todo_trailing.dart';

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
  final ValueNotifier<bool> _reachedNotifier = ValueNotifier(false);
  final ValueNotifier<double> _progressNotifier = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoOperationCubit, TodoOperationState>(
      builder: (context, state) {
        final isBeingProcessed = state is TodoOperationProcessingState &&
            state.todo.id == widget.todo.id;
        return AbsorbPointer(
          absorbing: isBeingProcessed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomCard(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Dismissible(
                  key: ValueKey(widget.todo.id),
                  dismissThresholds: const {
                    DismissDirection.startToEnd: 0.3,
                    DismissDirection.endToStart: 0.3,
                  },
                  onUpdate: (details) => _handleDragUpdate(details),
                  confirmDismiss: (direction) =>
                      _handleDismiss(direction, context),
                  background: ValueListenableBuilder<bool>(
                    valueListenable: _reachedNotifier,
                    builder: (context, reached, child) {
                      return ValueListenableBuilder<double>(
                        valueListenable: _progressNotifier,
                        builder: (context, progress, child) {
                          return DismissDoneBackground(
                            todo: widget.todo,
                            reached: reached,
                            progress: progress,
                          );
                        },
                      );
                    },
                  ),
                  secondaryBackground: ValueListenableBuilder<bool>(
                    valueListenable: _reachedNotifier,
                    builder: (context, reached, child) {
                      return ValueListenableBuilder<double>(
                        valueListenable: _progressNotifier,
                        builder: (context, progress, child) {
                          return DismissDeleteBackground(
                            reached: reached,
                            progress: progress,
                          );
                        },
                      );
                    },
                  ),
                  child: AnimatedSize(
                    duration: Durations.medium1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClickableCheckbox(todo: widget.todo),
                            TodoContent(widget: widget),
                            TodoTrailing(
                              isBeingProcessed: isBeingProcessed,
                              todo: widget.todo,
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
    _progressNotifier.value = details.progress;
    _reachedNotifier.value = details.reached;
  }

  Future<bool> _handleDismiss(
      DismissDirection direction, BuildContext context) async {
    final bloc = context.read<TodoListBloc>();
    final todo = widget.todo;
    if (direction == DismissDirection.startToEnd) {
      Log.i(
        'trying to change todo ${todo.id} completeness status to ${!todo.done}',
      );
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
      return false;
    } else if (direction == DismissDirection.endToStart) {
      final result =
          await DialogManager.showDeleteConfirmationDialog(context, todo);
      if (result != null && result) bloc.add(DeleteTodoEvent(widget.todo));
      return result ?? false;
    }
    return false;
  }
}
