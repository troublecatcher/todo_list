import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';

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
            S.of(context).noTodos,
            style: context.textTheme.displayLarge,
          ),
          Text(
            S.of(context).luckyYou,
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
