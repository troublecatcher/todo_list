import 'package:flutter/material.dart';
import 'package:todo_list/config/theme/theme.dart';
import 'package:todo_list/features/todo/presentation/layout/todo_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JUST TODO IT',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const TodoListScreen(),
    );
  }
}
