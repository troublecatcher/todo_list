import 'package:flutter/material.dart';
import 'package:todo_list/core/ui/custom_button_base.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';

class CreateTodoButton extends StatelessWidget {
  const CreateTodoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonBase(
      onPressed: () => Navigator.of(context).pushNamed(
        '/todo',
        arguments: CreateTodo(),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
