import 'package:flutter/material.dart';

class DialogManager {
  static Future<bool?> showDeleteConfirmationDialog(
      BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
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
        ) ??
        false;
  }
}
