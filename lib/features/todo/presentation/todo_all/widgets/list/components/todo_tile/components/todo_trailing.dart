import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/widget/custom_icon_button.dart';
import 'package:todo_list/core/ui/widget/loading_widget.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/common/todo_intent.dart';

class TodoTrailing extends StatelessWidget {
  final Todo todo;

  const TodoTrailing({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.medium1,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconButton(
            padding: const EdgeInsets.all(12),
            icon: Icons.info_outline,
            onPressed: () => Navigator.of(context).pushNamed(
              '/todo',
              arguments: EditTodoIntent(todo: todo),
            ),
            color: context.colorScheme.tertiary,
          ),
          AnimatedContainer(
            duration: Durations.medium1,
            width: 5,
            color: switch (todo.done) {
              true => context.customColors.green,
              false => switch (todo.importance) {
                  Importance.basic => null,
                  Importance.low => context.customColors.orange,
                  Importance.important => context.customColors.red,
                },
            },
          ),
        ],
      ),
    );
  }
}
