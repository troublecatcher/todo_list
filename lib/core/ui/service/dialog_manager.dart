import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/generated/l10n.dart';

class DialogManager {
  static Future<bool?> showDeleteConfirmationDialog(
      BuildContext context, Todo todo) async {
    Log.i('prompted to delete todo ${todo.id})');
    if (!GetIt.I<SharedPreferencesService>().confirmDialogs) {
      return true;
    }
    return await showDialog(
          context: context,
          builder: (context) => PopScope(
            onPopInvoked: (didPop) => Log.i('popped the todo delete dialog'),
            child: AlertDialog(
              title: Text(
                S.of(context).todoDeleteDialogTitle,
                style: context.textTheme.titleMedium,
              ),
              content: Text(
                S.of(context).todoDeleteDialogContent,
                style: context.textTheme.bodyMedium,
              ),
              actions: [
                CustomButtonBase(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    S.of(context).cancel,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                CustomButtonBase(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    S.of(context).delete,
                    style: context.textTheme.bodyMedium!
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
