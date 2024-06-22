import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/core/ui/custom_card.dart';
import 'package:todo_list/core/ui/custom_icon_button.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_event.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_state.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_action.dart';
import 'package:todo_list/features/todo/presentation/widgets/done_todo_count_widget.dart';
import 'package:todo_list/features/todo/presentation/widgets/fast_todo_creation_tile.dart';
import 'package:todo_list/features/todo/presentation/widgets/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _CustomHeaderDelegate(
                expandedHeight: 116,
                collapsedHeight: 56,
              ),
            ),
            BlocBuilder<TodoBloc, TodoState>(
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
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.done_outline,
                            size: 100,
                          ),
                          SizedBox(height: 20),
                          Text('Дел нет'),
                          Text('Счастливый Вы человек!'),
                          SizedBox(height: 100),
                        ],
                      ),
                    );
                  }
                  return SliverToBoxAdapter(
                    child: CustomCard(
                      margin: const EdgeInsets.only(
                        top: 16,
                        right: 16,
                        left: 16,
                        bottom: 120,
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                      ),
                    ),
                  );
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
        onPressed: () async {
          await _createTodo(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _createTodo(BuildContext context) async {
    final newTodo = await Navigator.of(context).pushNamed(
      '/todo',
      arguments: CreateTodo(),
    ) as Todo?;
    if (newTodo != null) {
      context.read<TodoBloc>().add(AddTodoEvent(newTodo));
    }
  }
}

class _CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double collapsedHeight;

  _CustomHeaderDelegate({
    required this.expandedHeight,
    required this.collapsedHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final collapsePercent = shrinkOffset / expandedHeight;
    final currentHeight =
        (1 - collapsePercent) * (expandedHeight - minExtent) + minExtent;
    final double subtitleHeight = 24.0 * (1 - collapsePercent);

    final shadowPercent =
        (collapsePercent >= 0.7) ? (collapsePercent - 0.7) / 0.3 : 0.0;

    return Container(
      height: currentHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: shadowPercent > 0
            ? [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5 * shadowPercent,
                  spreadRadius: 5 * shadowPercent,
                )
              ]
            : [],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: lerpDouble(60, 16, collapsePercent)!,
              bottom: lerpDouble(0, 16, collapsePercent)!,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Мои дела',
                  style: TextStyle(
                    fontSize: lerpDouble(32, 20, collapsePercent),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4 - 4 * collapsePercent),
                AnimatedContainer(
                  duration: Duration.zero,
                  height: subtitleHeight,
                  child: Opacity(
                    opacity: 1 - collapsePercent,
                    child: const DoneTodoCountWidget(),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _ToggleVisibilityButton(collapsePercent: collapsePercent),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _ToggleVisibilityButton extends StatefulWidget {
  const _ToggleVisibilityButton({required this.collapsePercent});

  final double collapsePercent;

  @override
  State<_ToggleVisibilityButton> createState() =>
      _ToggleVisibilityButtonState();
}

class _ToggleVisibilityButtonState extends State<_ToggleVisibilityButton> {
  VisibilityMode mode = VisibilityMode.undone;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: switch (mode) {
        VisibilityMode.undone => Icons.visibility,
        VisibilityMode.all => Icons.visibility_off,
      },
      onPressed: () {
        Log.i('toggle todo visibility to ${mode.name}');
        setState(() {
          switch (mode) {
            case VisibilityMode.undone:
              mode = VisibilityMode.all;
              // widget.todoBloc.allTodos();
              break;
            case VisibilityMode.all:
              mode = VisibilityMode.undone;
              // widget.todoBloc.undoneTodos();
              break;
          }
        });
      },
      color: Theme.of(context).colorScheme.primary,
      margin: EdgeInsets.only(
        right: lerpDouble(24, 0, widget.collapsePercent)!,
        bottom: lerpDouble(0, 6, widget.collapsePercent)!,
      ),
    );
  }
}

enum VisibilityMode { undone, all }
