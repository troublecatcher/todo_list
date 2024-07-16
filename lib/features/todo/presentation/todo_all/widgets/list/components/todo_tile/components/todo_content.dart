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
                  child: Text(
                    widget.todo.text,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: switch (widget.todo.done) {
                        true => context.colorScheme.tertiary,
                        false => null,
                      },
                      decoration: switch (widget.todo.done) {
                        true => TextDecoration.lineThrough,
                        false => TextDecoration.none,
                      },
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
