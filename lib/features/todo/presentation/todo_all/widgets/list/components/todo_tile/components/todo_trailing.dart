part of '../todo_tile.dart';

class TodoTrailing extends StatelessWidget {
  final Todo todo;
  final LayoutType type;

  const TodoTrailing({
    super.key,
    required this.todo,
    required this.type,
  });

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
          Transform.rotate(
            angle: pi,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                Icons.arrow_back_ios,
                color: context.dividerColor,
              ),
            ),
          ),
          AnimatedContainer(
            duration: Durations.medium1,
            width: 5,
            color: switch (todo.done) {
              true => null,
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
