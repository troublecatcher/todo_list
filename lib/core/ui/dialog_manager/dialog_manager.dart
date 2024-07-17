import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/extensions/extensions.dart';

import '../../../config/log/log.dart';
import '../../../config/l10n/generated/l10n.dart';
import '../../../features/todo/domain/domain.dart';
import '../../services/services.dart';
import '../ui.dart';

class DialogManager {
  static Future<bool?> showDeleteConfirmationDialog(
    BuildContext context,
    Todo todo,
  ) async {
    final bool confirmDialogs = GetIt.I<SettingsService>().confirmDialogs.value;
    if (!confirmDialogs) {
      return true;
    }
    Log.i('prompted to delete todo ${todo.id})');
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
                  onPressed: () => context.nav.goBack(false),
                  child: Text(
                    S.of(context).cancel,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                CustomButtonBase(
                  onPressed: () => context.nav.goBack(true),
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
