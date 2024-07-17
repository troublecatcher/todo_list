import 'dart:math';
import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type_provider.dart';

import '../../../../../../../../config/config.dart';
import '../../../../../../../../core/core.dart';
import '../../../../../../../features.dart';

part 'components/swipe_delete_background.dart';
part 'components/swipe_done_background.dart';
part 'components/todo_content.dart';
part 'components/todo_leading.dart';
part 'components/todo_trailing.dart';
part 'components/sync_widget.dart';

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
        return AbsorbPointer(
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                child: AnimatedSwitcher(
                                  duration: Durations.extralong1,
                                  transitionBuilder: (child, animation) =>
                                      FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                  child: isBeingProcessed
                                      ? const AnimatedSize(
                                          duration: Durations.medium1,
                                          child: SyncWidget(),
                                        )
                                      : const SizedBox(
                                          width: 25,
                                          height: 25,
                                        ),
                                ),
                              ),
                              TodoTrailing(todo: widget.todo),
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
      final result =
          await DialogManager.showDeleteConfirmationDialog(context, todo);
      if (result != null && result) {
        bloc.add(TodoDeleted(widget.todo));
        switch (type) {
          case LayoutType.tablet:
            // ignore: use_build_context_synchronously
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
        return colors.basicColor;
      case Importance.low:
        return colors.lowColor ?? context.customColors.orange;
      case Importance.important:
        return colors.importantColor ?? context.customColors.red;
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
