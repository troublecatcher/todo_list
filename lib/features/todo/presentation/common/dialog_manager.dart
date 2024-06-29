import 'package:flutter/material.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/core/extensions/extensions.dart';
import 'package:todo_list/core/ui/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/generated/l10n.dart';

class DialogManager {
  static Future<bool?> showDeleteConfirmationDialog(
      BuildContext context, Todo todo) async {
    Log.i('prompted to delete todo ${todo.id})');
    return await showDialog(
          context: context,
          builder: (context) => PopScope(
            onPopInvoked: (didPop) => Log.i('popped the todo delete dialog'),
            child: AlertDialog(
              title: Text(
                S.of(context).todoDeleteDialogTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              content: Text(
                S.of(context).todoDeleteDialogContent,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: [
                CustomButtonBase(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    S.of(context).cancel,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                CustomButtonBase(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    S.of(context).delete,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: context.customColors.red),
                  ),
                ),
              ],
            ),
          ),
        ) ??
        false;
  }
}
