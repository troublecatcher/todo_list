import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/features/todo/presentation/common/todo_intent.dart';

class CreateTodoButton extends StatelessWidget {
  const CreateTodoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonBase(
      onPressed: () => Navigator.of(context).pushNamed(
        '/todo',
        arguments: CreateTodoIntent(),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.primary,
        ),
        child: Icon(
          Icons.add,
          color: context.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
