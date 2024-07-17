import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/l10n/generated/l10n.dart';
import '../../../../../../core/core.dart';
import '../../../../../features.dart';

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
