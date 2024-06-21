import 'package:flutter/material.dart';

class TodoCountText extends StatelessWidget {
  final int count;
  const TodoCountText({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Выполнено — $count',
      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
    );
  }
}
