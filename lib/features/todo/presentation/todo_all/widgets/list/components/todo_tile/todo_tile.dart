import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/config/theme/remote_colors/remote_colors_cubit.dart';
import 'package:todo_list/config/theme/remote_colors/remote_colors_state.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/core/services/device_info_service.dart';
import 'package:todo_list/core/services/remote_config_service.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/core/ui/layout/custom_card.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation_cubit.dart';
import 'package:todo_list/core/ui/dialog_manager/dialog_manager.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/tablet/tablet_view_cubit.dart';

part 'components/swipe_delete_background.dart';
part 'components/swipe_done_background.dart';
part 'components/todo_content.dart';
part 'components/todo_leading.dart';
part 'components/todo_trailing.dart';

enum LayoutType { mobile, tablet }

class TodoTile extends StatefulWidget {
  final Todo todo;
  final LayoutType type;

  const TodoTile({
    super.key,
    required this.todo,
    required this.type,
  });

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
            padding: const EdgeInsets.symmetric(horizontal: 16).add(
              const EdgeInsets.only(bottom: 8),
            ),
            child: CustomButtonBase(
              shrinkFactor: 0.95,
              padding: EdgeInsets.zero,
              onPressed: switch (widget.type) {
                LayoutType.mobile => () =>
                    context.push('/todo', extra: widget.todo),
                LayoutType.tablet => () => context
                    .read<TabletViewCubit>()
                    .set(TabletViewTodoSelectedState(todo: widget.todo)),
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
                              TodoTrailing(
                                todo: widget.todo,
                                type: widget.type,
                              ),
                            ],
                          ),
                          BlocBuilder<RemoteColorsCubit, RemoteColorsState>(
                            builder: (context, colors) {
                              if (colors is RemoteColorsLoaded) {
                                return AnimatedContainer(
                                  duration: Durations.medium1,
                                  height: 5,
                                  color: widget.todo.done
                                      ? null
                                      : _getColorForImportance(
                                          widget.todo.importance,
                                          colors,
                                        ),
                                );
                              } else {
                                return AnimatedContainer(
                                  duration: Durations.medium1,
                                  height: 5,
                                  color: widget.todo.done
                                      ? null
                                      : _getDefaultColorForImportance(
                                          widget.todo.importance,
                                          context,
                                        ),
                                );
                              }
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
      if (result != null && result) {
        bloc.add(TodoDeleted(widget.todo));
        switch (widget.type) {
          case LayoutType.tablet:
            context.read<TabletViewCubit>().set(TabletViewInitialState());
            break;
          case LayoutType.mobile:
            break;
        }
      }
      return result ?? false;
    }
    return false;
  }

  Color? _getColorForImportance(
    Importance importance,
    RemoteColorsLoaded colors,
  ) {
    switch (importance) {
      case Importance.basic:
        return colors.importanceColorBasic;
      case Importance.low:
        return colors.importanceColorLow ?? context.customColors.orange;
      case Importance.important:
        return colors.importanceColorImportant ?? context.customColors.red;
      default:
        return Colors.transparent;
    }
  }

  Color? _getDefaultColorForImportance(
    Importance importance,
    BuildContext context,
  ) {
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
