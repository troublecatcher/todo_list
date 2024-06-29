import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/create_todo_button.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/custom_header_delegate.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_error_widget.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/layout/todo_list.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/layout/todo_shimmer_list.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/no_todos_placeholder.dart';

class TodoAllScreen extends StatefulWidget {
  const TodoAllScreen({super.key});

  @override
  State<TodoAllScreen> createState() => TodoAllScreenState();
}

class TodoAllScreenState extends State<TodoAllScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisibilityCubit(),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: CustomHeaderDelegate(
                  expandedHeight: 116,
                  collapsedHeight: 56,
                ),
              ),
              BlocBuilder<TodoListBloc, TodoState>(
                builder: (context, state) {
                  switch (state) {
                    case TodoLoading _:
                      return const TodoShimmerList();
                    case TodoError _:
                      return TodoErrorWidget(message: state.message);
                    case TodoInitial _:
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    case TodoLoaded loadedState:
                      final List<Todo> todos = loadedState.todos;
                      if (todos.isEmpty) {
                        return const NoTodosPlaceholder();
                      }
                      return TodoList(todos: todos);
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: const CreateTodoButton(),
      ),
    );
  }
}
