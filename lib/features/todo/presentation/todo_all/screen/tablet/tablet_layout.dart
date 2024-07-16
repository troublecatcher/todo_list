import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/duck_widget.dart';
import 'package:todo_list/features/settings/domain/state_management/duck/duck_cubit.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/main_list.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/tablet/tablet_view_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/done_todo_count_widget.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/settings_button.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_toggle_button.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/todo_tile.dart';
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
      appBar: AppBar(
        toolbarHeight: 116,
        flexibleSpace: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 60, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<TodoListBloc, TodoState>(
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 100),
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                        child: Text(
                          switch (state is TodoLoadInProgress) {
                            true => S.of(context).loading,
                            false => S.of(context).homeHeaderTitle,
                          },
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration: Duration.zero,
                    height: 24,
                    child: const DoneTodoCountWidget(),
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VisibilityToggleButton(collapsePercent: 1),
                  SettingsButton(collapsePercent: 1),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Builder(
              builder: (ctx) {
                return RefreshIndicator(
                  onRefresh: () async {
                    ctx.read<TabletViewCubit>().set(TabletViewInitialState());
                    ctx.read<TodoListBloc>().add(TodosFetchStarted());
                  },
                  child: const CustomScrollView(
                    slivers: [
                      MainList(type: LayoutType.tablet),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: BlocBuilder<TabletViewCubit, TabletViewState>(
              builder: (context, state) {
                switch (state) {
                  case TabletViewInitialState _:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_rounded,
                          size: 100,
                          color: context.colorScheme.primary,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          S.of(context).noTodoSelected,
                          style: context.textTheme.displayLarge,
                        ),
                      ],
                    );
                  case TabletViewTodoSelectedState s:
                    return TodoInfoLayout(
                      key: Key(state.todo.id),
                      todo: s.todo,
                      type: LayoutType.tablet,
                    );
                  case TabletViewNewTodoState _:
                    return const TodoInfoLayout(
                      todo: null,
                      type: LayoutType.tablet,
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
}
