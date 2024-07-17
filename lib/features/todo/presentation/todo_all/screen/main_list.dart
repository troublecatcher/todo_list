import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../todo.dart';

class MainList extends StatelessWidget {
  final LayoutType type;

  const MainList({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      sliver: BlocBuilder<TodoListBloc, TodoState>(
        builder: (context, state) {
          switch (state) {
            case TodoLoadInProgress _:
              return const TodoShimmerList();
            case TodoFailure _:
              return TodoErrorWidget(
                message: state.message,
              );
            case TodoInitial _:
              return const SliverToBoxAdapter(
                child: SizedBox.shrink(),
              );
            case TodoLoadSuccess loadedState:
              final List<Todo> todos = loadedState.todos;
              if (todos.isEmpty) {
                return const NoTodosPlaceholder();
              }
              return TodoList(
                todos: todos,
                type: type,
              );
          }
        },
      ),
    );
  }
}
