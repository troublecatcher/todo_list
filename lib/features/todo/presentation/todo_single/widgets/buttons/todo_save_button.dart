import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/core/extensions/navigation_extension.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type_provider.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/tablet/tablet_view_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';

class TodoSaveButton extends StatelessWidget {
  final Todo? currentTodo;

  const TodoSaveButton({super.key, required this.currentTodo});

  @override
  Widget build(BuildContext context) {
    final layoutType = LayoutTypeProvider.of(context);
    return BlocBuilder<TodoSingleCubit, Todo>(
      builder: (context, todo) {
        return CustomButtonBase(
          key: const Key('saveButton'),
          onPressed: todoHasText(todo)
              ? () => _handleTodoSaving(context, layoutType)
              : null,
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

  void _handleTodoSaving(BuildContext context, LayoutType type) {
    Todo newTodo = context.read<TodoSingleCubit>().assignMetadata(currentTodo);
    final TodoListBloc bloc = context.read<TodoListBloc>();
    if (currentTodo == null) {
      bloc.add(TodoAdded(newTodo));
    } else {
      bloc.add(TodoUpdated(newTodo));
    }
    switch (type) {
      case LayoutType.mobile:
        context.nav.goBack();
        break;
      case LayoutType.tablet:
        context.read<TabletViewCubit>().set(TabletViewInitialState());
        break;
    }
  }

  bool todoHasText(Todo todo) => todo.text.isNotEmpty;
}
