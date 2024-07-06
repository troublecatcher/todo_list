import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/connectivity/connectivity_cubit.dart';
import 'package:todo_list/config/connectivity/connectivity_state.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_state.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VisibilityCubit(),
        ),
        BlocProvider(
          create: (context) => ConnectivityCubit(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: BlocListener<ConnectivityCubit, ConnectivityState>(
            listener: (context, state) {
              if (state is ConnectivityOffline) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 0,
                    dismissDirection: DismissDirection.none,
                    content: const Align(
                      alignment: Alignment.center,
                      child: Text('Offline mode'),
                    ),
                    backgroundColor: context.dividerColor,
                    duration: const Duration(days: 365),
                  ),
                );
              } else if (state is ConnectivityOnline) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 0,
                    dismissDirection: DismissDirection.none,
                    content: const Align(
                      alignment: Alignment.center,
                      child: Text('Back online'),
                    ),
                    backgroundColor: context.customColors.green,
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
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
          ),
        ),
        floatingActionButton: const CreateTodoButton(),
      ),
    );
  }
}
