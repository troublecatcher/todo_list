import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/ui/widget/duck_widget.dart';
import 'package:todo_list/features/settings/domain/state_management/duck/duck_cubit.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/tablet_layout/no_selection_placeholder.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/tablet_layout/tablet_layout_header.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/tablet_layout/tablet_layout_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/common/list/layout/todo_list_base.dart';
import 'package:todo_list/features/todo/presentation/todo_single/screen/todo_info_layout.dart';

class TabletLayout extends StatefulWidget {
  const TabletLayout({super.key});

  @override
  State<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TabletHeader(),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Builder(
              builder: (ctx) {
                return RefreshIndicator(
                  onRefresh: () async => _onRefresh(ctx),
                  child: const CustomScrollView(
                    slivers: [TodoListBase()],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: BlocBuilder<TabletLayoutCubit, TabletLayoutState>(
              builder: (context, state) {
                switch (state) {
                  case TabletLayoutInitialState _:
                    return const NoSelectionPlaceholder();
                  case TabletLayoutTodoSelectedState s:
                    return TodoInfoLayout(
                      key: Key(state.todo.id),
                      todo: s.todo,
                    );
                  case TabletLayoutNewTodoState _:
                    return const TodoInfoLayout(
                      todo: null,
                    );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: BlocBuilder<DuckCubit, bool>(
        builder: (context, state) {
          if (state == true) {
            return const DuckWidget();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  void _onRefresh(BuildContext ctx) {
    ctx.read<TabletLayoutCubit>().set(TabletLayoutInitialState());
    ctx.read<TodoListBloc>().add(TodosFetchStarted());
  }
}
