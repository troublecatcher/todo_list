import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/todo_tile.dart';

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
                if (!widget.todo.done)
                  switch (widget.todo.importance) {
                    Importance.important => Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/priority/high.svg',
                          ),
                          const SizedBox(width: 3),
                        ],
                      ),
                    Importance.low => Row(
                        children: [
                          SvgPicture.asset('assets/icons/priority/low.svg'),
                          const SizedBox(width: 3),
                        ],
                      ),
                    Importance.basic => const SizedBox.shrink(),
                  },
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
                    FormattingHelper.formatDate(widget.todo.deadline!),
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