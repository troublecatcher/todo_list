import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/services/preferences/preferences_service/preferences_service.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';

class DialogManager {
  static Future<bool?> showDeleteConfirmationDialog(
    BuildContext context,
    TodoEntity todo,
  ) async {
    Log.i('prompted to delete todo ${todo.id})');
    final bool confirmDialogs =
        GetIt.I<PreferencesService>().confirmDialogs.value;
    if (!confirmDialogs) {
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
                  onPressed: () => context.pop(false),
                  child: Text(
                    S.of(context).cancel,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                CustomButtonBase(
                  onPressed: () => context.pop(true),
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
