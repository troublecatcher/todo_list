import 'package:flutter/material.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';

class TodoErrorWidget extends StatelessWidget {
  final String message;
  const TodoErrorWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text(
          S.of(context).errorMessage(message),
        ),
      ),
    );
  }
}
