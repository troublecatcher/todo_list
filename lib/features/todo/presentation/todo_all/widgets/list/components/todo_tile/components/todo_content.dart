part of '../todo_tile.dart';

class TodoContent extends StatelessWidget {
  const TodoContent({
    super.key,
    required this.widget,
  });

  final TodoTile widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AnimatedLineThrough(
                    duration: Durations.long2,
                    isCrossed: widget.todo.done,
                    strokeWidth: 2,
                    curve: Curves.easeOutCirc,
                    color: context.colorScheme.tertiary,
                    child: Text(
                      widget.todo.text,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: widget.todo.done
                            ? context.colorScheme.tertiary
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (widget.todo.deadline != null)
              Column(
                children: [
                  const SizedBox(height: 4),
                  Text(
                    widget.todo.deadline!.formattedDate,
                    style: context.textTheme.labelMedium!.copyWith(
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
