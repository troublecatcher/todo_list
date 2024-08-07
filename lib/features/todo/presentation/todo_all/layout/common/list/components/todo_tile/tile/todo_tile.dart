import 'dart:math';
import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/config/log/logger.dart';
import 'package:todo_list/config/theme/remote_colors/remote_colors_cubit.dart';
import 'package:todo_list/core/extensions/datetime_extension.dart';
import 'package:todo_list/core/extensions/navigation_extension.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/services/device_info_service.dart';
import 'package:todo_list/core/ui/dialog_manager/dialog_manager.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/core/ui/layout/custom_card.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type_provider.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/tablet_layout/tablet_layout_cubit.dart';

part '../components/swipe_delete_background.dart';
part '../components/swipe_done_background.dart';
part '../components/todo_content.dart';
part '../components/todo_leading.dart';
part '../components/todo_trailing.dart';
part '../components/sync_widget.dart';

class TodoTile extends StatefulWidget {
  final Todo todo;

  const TodoTile({super.key, required this.todo});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  final ValueNotifier<bool> _reachedNotifier = ValueNotifier(false);
  final ValueNotifier<double> _progressNotifier = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    final layoutType = LayoutTypeProvider.of(context);
    return BlocBuilder<TodoOperationCubit, TodoOperationState>(
      builder: (context, state) {
        final bool isBeingProcessed = state is TodoOperationProcessingState &&
            state.todo.id == widget.todo.id;
        return Hero(
          tag: widget.todo.id,
          child: AbsorbPointer(
            absorbing: isBeingProcessed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).add(
                const EdgeInsets.only(bottom: 8),
              ),
              child: CustomButtonBase(
                shrinkFactor: 0.95,
                padding: EdgeInsets.zero,
                onPressed: switch (layoutType) {
                  LayoutType.mobile => () =>
                      context.nav.goTodoSingle(todo: widget.todo),
                  LayoutType.tablet => () => context
                      .read<TabletLayoutCubit>()
                      .set(TabletLayoutTodoSelectedState(todo: widget.todo)),
                },
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
                          _handleDismiss(direction, context, layoutType),
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
                        curve: Curves.easeInOutCirc,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TodoLeading(todo: widget.todo),
                                TodoContent(widget: widget),
                                SyncWidget(isBeingProcessed: isBeingProcessed),
                                TodoTrailing(todo: widget.todo),
                              ],
                            ),
                            BlocBuilder<RemoteColorsCubit, RemoteColorsState>(
                              builder: (context, colors) {
                                return AnimatedContainer(
                                  duration: Durations.medium1,
                                  height: 5,
                                  color: _determineColor(
                                    widget.todo.importance,
                                    colors,
                                    context,
                                    widget.todo.done,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
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
    LayoutType type,
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
      final layoutCubit = context.read<TabletLayoutCubit>();
      final result =
          await DialogManager.showDeleteConfirmationDialog(context, todo);
      if (result != null && result) {
        bloc.add(TodoDeleted(widget.todo));
        switch (type) {
          case LayoutType.tablet:
            layoutCubit.set(TabletLayoutInitialState());
            break;
          case LayoutType.mobile:
            break;
        }
      }
      return result ?? false;
    }
    return false;
  }

  Color? _determineColor(
    Importance importance,
    RemoteColorsState colorsState,
    BuildContext context,
    bool done,
  ) {
    if (done) return null;

    if (colorsState is RemoteColorsLoaded) {
      switch (importance) {
        case Importance.basic:
          return colorsState.basicColor;
        case Importance.low:
          return colorsState.lowColor ?? context.customColors.orange;
        case Importance.important:
          return colorsState.importantColor ?? context.customColors.red;
        default:
          return Colors.transparent;
      }
    } else {
      switch (importance) {
        case Importance.basic:
          return null;
        case Importance.low:
          return context.customColors.orange;
        case Importance.important:
          return context.customColors.red;
        default:
          return Colors.transparent;
      }
    }
  }
}
