import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/connectivity_indicator.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/custom_header_delegate.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/layout/todo_list.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/layout/todo_shimmer_list.dart';

class TodoAllScreen extends StatefulWidget {
  const TodoAllScreen({super.key});

  @override
  State<TodoAllScreen> createState() => TodoAllScreenState();
}

class TodoAllScreenState extends State<TodoAllScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VisibilityCubit()),
      ],
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Container(
            color: context.scaffoldBackgroundColor,
            child: Column(
              children: [
                const ConnectivityIndicator(),
                Expanded(
                  child: RefreshIndicator(
                    edgeOffset: 124,
                    onRefresh: () async =>
                        context.read<TodoListBloc>().add(TodosFetchStarted()),
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
                              case TodoLoadInProgress _:
                                return const TodoShimmerList();
                              case TodoFailure _:
                                return TodoErrorWidget(message: state.message);
                              case TodoInitial _:
                                return const SliverToBoxAdapter(
                                  child: SizedBox.shrink(),
                                );
                              case TodoLoadSuccess loadedState:
                                final List<TodoEntity> todos =
                                    loadedState.todos;
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
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: const CreateTodoButton(),
      ),
    );
  }
}
