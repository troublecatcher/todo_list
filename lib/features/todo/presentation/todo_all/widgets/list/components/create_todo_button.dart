import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';

class CreateTodoButton extends StatelessWidget {
  const CreateTodoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonBase(
      onPressed: () => context.push('/todo'),
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
