import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/extensions/navigation_extension.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/tablet/tablet_view_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/todo_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';

class TodoSaveButton extends StatelessWidget {
  final Todo? currentTodo;
  final LayoutType type;

  const TodoSaveButton({
    super.key,
    required this.currentTodo,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoSingleCubit, Todo>(
      builder: (context, todo) {
        return CustomButtonBase(
          key: const Key('saveButton'),
          onPressed:
              todoHasText(todo) ? () => _handleTodoSaving(context) : null,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              S.of(context).todoSaveButtonTitle,
              style: context.textTheme.titleMedium!
                  .copyWith(color: context.colorScheme.onPrimary),
            ),
          ),
        );
      },
    );
  }

  void _handleTodoSaving(BuildContext context) {
    Todo newTodo = context.read<TodoSingleCubit>().assignMetadata(currentTodo);
    final TodoListBloc bloc = context.read<TodoListBloc>();
    if (currentTodo == null) {
      bloc.add(TodoAdded(newTodo));
    } else {
      bloc.add(TodoUpdated(newTodo));
    }
    switch (type) {
      case LayoutType.mobile:
        context.nav.pop();
        break;
      case LayoutType.tablet:
        context.read<TabletViewCubit>().set(TabletViewInitialState());
        break;
    }
  }

  bool todoHasText(Todo todo) => todo.text.isNotEmpty;
}
