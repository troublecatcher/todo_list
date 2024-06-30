import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/widget/custom_icon_button.dart';
import 'package:todo_list/core/ui/widget/loading_widget.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/common/todo_intent.dart';

class TodoTrailing extends StatelessWidget {
  final Todo todo;
  final bool isBeingProcessed;

  const TodoTrailing({
    super.key,
    required this.todo,
    required this.isBeingProcessed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.medium1,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: isBeingProcessed
          ? const LoadingWidget()
          : CustomIconButton(
              padding: const EdgeInsets.only(
                top: 12,
                right: 16,
                bottom: 12,
                left: 12,
              ),
              icon: Icons.info_outline,
              onPressed: () => Navigator.of(context).pushNamed(
                '/todo',
                arguments: EditTodoIntent(todo: todo),
              ),
              color: context.colorScheme.tertiary,
            ),
    );
  }
}
