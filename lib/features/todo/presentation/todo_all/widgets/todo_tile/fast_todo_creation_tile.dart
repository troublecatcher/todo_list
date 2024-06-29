import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/extensions/build_context_extension.dart';
import 'package:todo_list/core/ui/custom_card.dart';
import 'package:todo_list/core/ui/custom_icon_button.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/generated/l10n.dart';
import 'package:uuid/uuid.dart';

class FastTodoCreationTile extends StatefulWidget {
  const FastTodoCreationTile({super.key});

  @override
  State<FastTodoCreationTile> createState() => _FastTodoCreationTileState();
}

class _FastTodoCreationTileState extends State<FastTodoCreationTile> {
  final fastTodoNameController = TextEditingController();
  String? newTodoId;
  bool isBeingProcessed = false;

  @override
  void dispose() {
    fastTodoNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTextPresent = fastTodoNameController.text.isNotEmpty;
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        isBeingProcessed = state is TodoOperationBeingPerformed &&
            state.todoToBeMutated.id == newTodoId;
        return AbsorbPointer(
          absorbing: isBeingProcessed,
          child: CustomCard.shimmer(
            enabled: isBeingProcessed,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: Durations.medium4,
                  reverseDuration: Duration.zero,
                  transitionBuilder: (child, animation) {
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    );
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(-0.3, 0.0),
                      end: Offset.zero,
                    ).animate(curvedAnimation);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: FadeTransition(
                        opacity: curvedAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: isTextPresent
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16, right: 12),
                          child: Icon(
                            Icons.check_box_outline_blank,
                            color: context.dividerColor,
                          ),
                        )
                      : const SizedBox(width: 52),
                ),
                Expanded(
                  child: TextField(
                    controller: fastTodoNameController,
                    style: context.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: S.of(context).todoFastCreateTitle,
                      hintStyle: context.textTheme.bodyMedium!
                          .copyWith(color: context.colorScheme.tertiary),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                AnimatedSwitcher(
                  duration: Durations.medium4,
                  reverseDuration: Duration.zero,
                  transitionBuilder: (child, animation) {
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    );
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(0.3, 0.0),
                      end: Offset.zero,
                    ).animate(curvedAnimation);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: FadeTransition(
                        opacity: curvedAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: isTextPresent
                      ? Builder(
                          builder: (context) {
                            if (isBeingProcessed) {
                              return const SizedBox.shrink();
                            } else {
                              return CustomIconButton(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 16),
                                icon: Icons.arrow_circle_up_rounded,
                                onPressed: () async {
                                  const uuid = Uuid();
                                  newTodoId = uuid.v4();
                                  context.read<TodoListBloc>().add(
                                        AddTodoEvent(
                                          Todo(
                                            text: fastTodoNameController.text,
                                            importance: Importance.basic,
                                            deadline: null,
                                            done: false,
                                          )
                                            ..id = newTodoId!
                                            ..createdAt = DateTime.now()
                                            ..changedAt = DateTime.now()
                                            ..lastUpdatedBy = 'RyanGosling',
                                        ),
                                      );
                                },
                                color: context.colorScheme.primary,
                              );
                            }
                          },
                        )
                      : const SizedBox(width: 52),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
