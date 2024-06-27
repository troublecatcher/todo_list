import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/create_todo_button.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/custom_header_delegate.dart';
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
    return Scaffold(
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
                    return const SliverToBoxAdapter(
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
                    return SliverList.builder(
                      itemCount: todos.length + 1,
                      itemBuilder: (context, index) {
                        if (index == todos.length) {
                          return const FastTodoCreationTile();
                        } else {
                          final Todo todo = todos[index];
                          return TodoTile(todo: todo);
                        }
                      },
                    );
                  case TodoInitial _:
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                }
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 110))
          ],
        ),
      ),
      floatingActionButton: const CreateTodoButton(),
      // floatingActionButton: IconButton(
      //   onPressed: () async {
      //     context.read<TodoListBloc>().add(Fetch());
      //   },
      //   icon: const Icon(Icons.abc),
      // ),
    );
  }
}
