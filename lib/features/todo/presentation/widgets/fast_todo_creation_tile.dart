import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/ui/custom_icon_button.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';

class FastTodoCreationTile extends StatefulWidget {
  const FastTodoCreationTile({super.key});

  @override
  State<FastTodoCreationTile> createState() => _FastTodoCreationTileState();
}

class _FastTodoCreationTileState extends State<FastTodoCreationTile> {
  final fastTodoNameController = TextEditingController();

  @override
  void dispose() {
    fastTodoNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTextPresent = fastTodoNameController.text.isNotEmpty;
    return Row(
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
                    color: Theme.of(context).dividerColor,
                  ),
                )
              : const SizedBox(width: 52),
        ),
        Expanded(
          child: TextField(
            controller: fastTodoNameController,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              hintText: 'Новое...',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.tertiary),
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
              ? CustomIconButton(
                  padding: const EdgeInsets.only(left: 12, right: 16),
                  icon: Icons.send_rounded,
                  onPressed: () async {
                    context.read<TodoBloc>().add(
                          AddTodoEvent(
                            Todo(
                              content: fastTodoNameController.text,
                              priority: TodoPriority.none,
                              deadline: null,
                              done: false,
                            ),
                          ),
                        );
                  },
                  color: Theme.of(context).colorScheme.primary,
                )
              : const SizedBox(width: 52),
        ),
      ],
    );
  }
}
