import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/core/services/device_info_service.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/core/ui/layout/custom_card.dart';
import 'package:todo_list/core/ui/widget/custom_icon_button.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation_cubit.dart';
import 'package:todo_list/core/ui/dialog_manager/dialog_manager.dart';

part 'components/swipe_delete_background.dart';
part 'components/swipe_done_background.dart';
part 'components/todo_content.dart';
part 'components/todo_leading.dart';
part 'components/todo_trailing.dart';

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
        final bool isBeingProcessed = state is TodoOperationProcessingState &&
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
                  onDismissed: (direction) => setState(() {}),
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
                    duration: Durations.long4,
                    curve: Curves.elasticOut,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TodoLeading(todo: widget.todo),
                              TodoContent(widget: widget),
                              TodoTrailing(todo: widget.todo),
                            ],
                          ),
                        ),
                        switch (isBeingProcessed) {
                          true => const LinearProgressIndicator(
                              backgroundColor: Colors.transparent,
                            ),
                          false => const SizedBox(height: 4),
                        },
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
    DismissDirection direction,
    BuildContext context,
  ) async {
    final bloc = context.read<TodoListBloc>();
    final todo = widget.todo;
    if (direction == DismissDirection.startToEnd) {
      Log.i(
        'trying to change todo ${todo.id} completeness status to ${!todo.done}',
      );
      bloc.add(
        TodoUpdated(
          todo.copyWith(
            done: !todo.done,
            changedAt: DateTime.now(),
            lastUpdatedBy: GetIt.I<DeviceInfoService>().info,
          ),
        ),
      );
      return false;
    } else if (direction == DismissDirection.endToStart) {
      final result =
          await DialogManager.showDeleteConfirmationDialog(context, todo);
      if (result != null && result) bloc.add(TodoDeleted(widget.todo));
      return result ?? false;
    }
    return false;
  }
}
