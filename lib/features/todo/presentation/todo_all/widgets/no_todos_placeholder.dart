import 'package:flutter/material.dart';

class NoTodosPlaceholder extends StatelessWidget {
  const NoTodosPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.done_all_rounded,
          size: 100,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 20),
        Text(
          'Дел нет',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          'Счастливый Вы человек!',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
