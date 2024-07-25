import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/common/list/layout/todo_list.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/common/list/layout/todo_shimmer_list.dart';

class TodoListBase extends StatelessWidget {
  const TodoListBase({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      sliver: BlocBuilder<TodoListBloc, TodoState>(
        builder: (context, state) {
          switch (state) {
            case TodoLoadInProgress _:
              return const TodoShimmerList();
            case TodoFailure _:
              return TodoErrorWidget(message: state.error);
            case TodoUnauthorized _:
              return TodoErrorWidget(message: S.of(context).theTokenIsInvalid);
            case TodoInitial _:
              return const SliverToBoxAdapter(
                child: SizedBox.shrink(),
              );
            case TodoLoadSuccess loadedState:
              final List<Todo> todos = loadedState.todos;
              if (todos.isEmpty) {
                return const NoTodosPlaceholder();
              }
              return TodoList(todos: todos);
          }
        },
      ),
    );
  }
}
