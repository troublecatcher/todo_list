import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/l10n/generated/l10n.dart';
import '../../../../../../core/core.dart';
import '../../../../../features.dart';

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
        context.nav.goBack();
        break;
      case LayoutType.tablet:
        context.read<TabletViewCubit>().set(TabletViewInitialState());
        break;
    }
  }

  bool todoHasText(Todo todo) => todo.text.isNotEmpty;
}
