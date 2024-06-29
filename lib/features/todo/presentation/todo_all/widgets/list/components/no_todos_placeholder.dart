import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/build_context_extension.dart';

class NoTodosPlaceholder extends StatelessWidget {
  const NoTodosPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.done_all_rounded,
            size: 100,
            color: context.colorScheme.primary,
          ),
          const SizedBox(height: 20),
          Text(
            'Дел нет',
            style: context.textTheme.displayLarge,
          ),
          Text(
            'Счастливый Вы человек!',
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
