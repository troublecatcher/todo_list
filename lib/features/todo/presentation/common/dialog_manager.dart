import 'package:flutter/material.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';

class DialogManager {
  static Future<bool?> showDeleteConfirmationDialog(
      BuildContext context, Todo todo) async {
    Log.i('prompted to delete todo (id ${todo.id})');
    return await showDialog(
          context: context,
          builder: (context) => PopScope(
            onPopInvoked: (didPop) => Log.i('popped the todo delete dialog'),
            child: AlertDialog(
              title: const Text(
                'Уверены, что хотите удалить дело?',
              ),
              content: const Text(
                'Это действие необратимо',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('НЕТ'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('ДА'),
                ),
              ],
            ),
          ),
        ) ??
        false;
  }
}