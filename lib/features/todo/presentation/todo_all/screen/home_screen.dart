import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/create_todo_button.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/custom_header_delegate.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_mode.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/no_todos_placeholder.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/todo_tile/fast_todo_creation_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/todo_tile/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
                      return const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    case TodoError _:
                      return SliverToBoxAdapter(
                        child: Center(child: Text('Ошибка: ${state.message}')),
                      );
                    case TodoLoaded todoLoadedState:
                      final List<Todo> todos = todoLoadedState.todos;
                      if (todos.isEmpty) {
                        return const SliverFillRemaining(
                          hasScrollBody: false,
                          child: NoTodosPlaceholder(),
                        );
                      }
                      return BlocBuilder<VisibilityCubit, VisibilityMode>(
                        builder: (context, mode) {
                          List<Todo> maybeModifiedTodos = todos;
                          if (mode == VisibilityMode.undone) {
                            maybeModifiedTodos =
                                todos.where((todo) => !todo.done).toList();
                          }
                          return SliverPadding(
                            padding:
                                const EdgeInsets.only(top: 16, bottom: 110),
                            sliver: SliverList.builder(
                              itemCount: maybeModifiedTodos.length + 1,
                              itemBuilder: (context, index) {
                                if (index == maybeModifiedTodos.length) {
                                  return const FastTodoCreationTile();
                                } else {
                                  final Todo todo = maybeModifiedTodos[index];
                                  return TodoTile(todo: todo);
                                }
                              },
                            ),
                          );
                        },
                      );
                    case TodoInitial _:
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
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
