import 'package:flutter/material.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';

class CreateTodoButton extends StatelessWidget {
  const CreateTodoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).pushNamed(
        '/todo',
        arguments: CreateTodo(),
      ),
      child: const Icon(Icons.add),
    );
  }
}
