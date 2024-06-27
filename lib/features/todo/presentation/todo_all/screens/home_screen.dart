import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/ui/custom_card.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/custom_header_delegate.dart';
import 'package:todo_list/features/todo/presentation/todo_single/utility/todo_action.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/fast_todo_creation_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/todo_tile.dart';

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
                if (state is TodoLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is TodoError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Ошибка: ${state.message}')),
                  );
                } else if (state is TodoLoaded) {
                  final todos = state.todos;
                  if (todos.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.done_all_rounded,
                            size: 100,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Дел нет',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            'Счастливый Вы человек!',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    );
                  }
                  return SliverList.builder(
                    itemCount: todos.length + 1,
                    itemBuilder: (context, index) {
                      if (index == todos.length) {
                        return const FastTodoCreationTile();
                      } else {
                        final Todo todo = todos[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: index == 0
                                ? const Radius.circular(8)
                                : Radius.zero,
                          ),
                          child: TodoTile(todo: todo),
                        );
                      }
                    },
                  );
                  // return SliverToBoxAdapter(
                  //   child: CustomCard(
                  //     margin: const EdgeInsets.only(
                  //       top: 16,
                  //       right: 16,
                  //       left: 16,
                  //       bottom: 120,
                  //     ),
                  //     child: ListView.builder(
                  //       padding: EdgeInsets.zero,
                  //       shrinkWrap: true,
                  //       physics: const NeverScrollableScrollPhysics(),
                  //       itemCount: todos.length + 1,
                  //       itemBuilder: (context, index) {
                  //         if (index == todos.length) {
                  //           return const FastTodoCreationTile();
                  //         } else {
                  //           final Todo todo = todos[index];
                  //           return ClipRRect(
                  //             borderRadius: BorderRadius.vertical(
                  //               top: index == 0
                  //                   ? const Radius.circular(8)
                  //                   : Radius.zero,
                  //             ),
                  //             child: TodoTile(todo: todo),
                  //           );
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // );
                } else {
                  return const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          '/todo',
          arguments: CreateTodo(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
