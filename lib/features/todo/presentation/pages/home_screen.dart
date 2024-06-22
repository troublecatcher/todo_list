import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/core/ui/custom_card.dart';
import 'package:todo_list/core/ui/custom_icon_button.dart';
import 'package:todo_list/features/todo/data/isar_service.dart';
import 'package:todo_list/features/todo/presentation/controller/todo_controller.dart';
import 'package:todo_list/features/todo/domain/todo.dart';
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
  late Future<TodoController> todoBlocFuture;

  @override
  void initState() {
    super.initState();
    todoBlocFuture = IsarService().initializeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TodoController>(
      future: todoBlocFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Что-то пошло не так.'));
        }
        final todoBloc = snapshot.data!;

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
                    todoBloc: todoBloc,
                  ),
                ),
                StreamBuilder<List<Todo>>(
                  stream: todoBloc.todos,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (snapshot.hasError) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text('Ошибка: ${snapshot.error}')),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                    final todos = snapshot.data!;
                    return SliverToBoxAdapter(
                      child: CustomCard(
                        margin: const EdgeInsets.only(
                          top: 16,
                          right: 16,
                          left: 16,
                          bottom: 120,
                        ),
                        // this is most likely to be refactored in the future
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: todos.length + 1,
                          itemBuilder: (context, index) {
                            if (index == todos.length) {
                              return FastTodoCreationTile(todoBloc: todoBloc);
                            } else {
                              final Todo todo = todos[index];
                              return ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: index == 0
                                      ? const Radius.circular(8)
                                      : Radius.zero,
                                ),
                                child: TodoTile(todo: todo, todoBloc: todoBloc),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await _createTodo(context, todoBloc);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Future<void> _createTodo(
      BuildContext context, TodoController todoBloc) async {
    final newTodo = await Navigator.of(context).pushNamed(
      '/todo',
      arguments: CreateTodo(),
    ) as Todo?;
    if (newTodo != null) {
      await todoBloc.addTodo(newTodo);
    }
  }
}

class _CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double collapsedHeight;
  final TodoController todoBloc;

  _CustomHeaderDelegate(
      {required this.expandedHeight,
      required this.collapsedHeight,
      required this.todoBloc});

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
                    child: DoneTodoCountWidget(todoBloc: todoBloc),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _ToggleVisibilityButton(
              collapsePercent: collapsePercent,
              todoBloc: todoBloc,
            ),
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
  final TodoController todoBloc;

  const _ToggleVisibilityButton({
    required this.collapsePercent,
    required this.todoBloc,
  });

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
              widget.todoBloc.allTodos();
              break;
            case VisibilityMode.all:
              mode = VisibilityMode.undone;
              widget.todoBloc.undoneTodos();
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
