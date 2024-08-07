import 'package:flutter/material.dart';
import 'package:todo_list/core/ui/widget/custom_back_button.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/screen/todo_single_screen_layout.dart';

class TodoSingleScreen extends StatelessWidget {
  final Todo? todo;
  const TodoSingleScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 5,
        leading: const CustomBackButton(),
      ),
      body: SafeArea(
        bottom: false,
        child: TodoSingleScreenLayout(todo: todo),
      ),
    );
  }
}
