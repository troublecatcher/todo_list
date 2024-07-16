part of '../layout/todo_list.dart';

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
    return BlocBuilder<TodoOperationCubit, TodoOperationState>(
      builder: (context, state) {
        isBeingProcessed =
            state is TodoOperationProcessingState && state.todo.id == newTodoId;
        return AbsorbPointer(
          absorbing: isBeingProcessed,
          child: CustomCard(
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
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            Icons.check_box_outline_blank,
                            color: context.dividerColor,
                          ),
                        )
                      : const SizedBox(width: 52),
                ),
                Expanded(
                  child: TextField(
                    key: const Key('fastTodoTextField'),
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
                              return const LoadingWidget();
                            } else {
                              return CustomIconButton(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12 + 5,
                                ),
                                icon: Icons.arrow_circle_up_rounded,
                                onPressed: () async {
                                  const uuid = Uuid();
                                  newTodoId = uuid.v4();
                                  context.read<TodoListBloc>().add(
                                        TodoAdded(
                                          Todo(
                                            id: newTodoId!,
                                            text: fastTodoNameController.text,
                                            importance: Importance.basic,
                                            deadline: null,
                                            done: false,
                                            createdAt: DateTime.now(),
                                            changedAt: DateTime.now(),
                                            lastUpdatedBy:
                                                GetIt.I<DeviceInfoService>()
                                                    .info,
                                          ),
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
