import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/core/extensions/datetime_extension.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';

class TodoDeadlineSelectionTile extends StatelessWidget {
  const TodoDeadlineSelectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoSingleCubit, Todo>(
      builder: (context, todo) {
        return AnimatedSize(
          duration: Durations.medium1,
          child: Material(
            color: Colors.transparent,
            child: SwitchListTile(
              value: todo.deadline != null,
              onChanged: (value) async =>
                  await _handleDateSelection(value, context),
              contentPadding: EdgeInsets.zero,
              title: Text(
                S.of(context).todoDeadline,
                style: context.textTheme.bodyMedium,
              ),
              subtitle: todo.deadline != null
                  ? Text(
                      todo.deadline!.formattedDate,
                      style: context.textTheme.labelMedium!
                          .copyWith(color: context.colorScheme.primary),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleDateSelection(
    bool includeDeadline,
    BuildContext context,
  ) async {
    final cubit = context.read<TodoSingleCubit>();
    if (includeDeadline) {
      final newDeadline = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 1000)),
      );
      if (newDeadline != null) cubit.changeDeadline(newDeadline);
    } else {
      cubit.changeDeadline(null);
    }
  }
}
