import 'package:flutter/material.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';

class NoSelectionPlaceholder extends StatelessWidget {
  const NoSelectionPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.note_rounded,
          size: 100,
          color: context.colorScheme.primary,
        ),
        const SizedBox(height: 20),
        Text(
          S.of(context).noTodoSelected,
          style: context.textTheme.displayLarge,
        ),
      ],
    );
  }
}
