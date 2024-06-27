import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/cubit/single_todo_cubit.dart';

class TodoDeadlineSelectionTile extends StatelessWidget {
  const TodoDeadlineSelectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleTodoCubit, Todo>(
      builder: (context, todo) {
        return AnimatedSize(
          duration: Durations.medium1,
          child: SwitchListTile(
            value: todo.deadline != null,
            onChanged: (value) async =>
                await _handleDateSelection(value, context),
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Сделать до',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: todo.deadline != null
                ? Text(
                    FormattingHelper.formatDate(todo.deadline!),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  )
                : null,
          ),
        );
      },
    );
  }

  Future<void> _handleDateSelection(
      bool includeDeadline, BuildContext context) async {
    final cubit = context.read<SingleTodoCubit>();
    if (includeDeadline) {
      final newDeadline = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (newDeadline != null) {
        cubit.changeDeadline(newDeadline);
      }
    } else {
      cubit.changeDeadline(null);
    }
  }
}
