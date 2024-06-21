import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todo_list/core/custom_card.dart';
import 'package:todo_list/features/todo/data/isar_service.dart';
import 'package:todo_list/features/todo/presentation/state_management/todo_controller.dart';
import 'package:todo_list/features/todo/domain/todo.dart';
import 'package:todo_list/features/todo/presentation/pages/new_todo_screen.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_action.dart';
import 'package:todo_list/features/todo/presentation/widgets/done_todo_count_widget.dart';
import 'package:todo_list/features/todo/presentation/widgets/todo_tile.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late Future<TodoController> todoBlocFuture;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    todoBlocFuture = IsarService().initializeBloc();
    scrollController.addListener(() {
      print(scrollController.offset);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
                  delegate: _MySliverPersistentHeaderDelegate(
                      expandedHeight: 116,
                      collapsedHeight: 56,
                      todoBloc: todoBloc),
                ),
                StreamBuilder<List<Todo>>(
                  stream: todoBloc.todos,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverToBoxAdapter(
                        child: Center(child: Text('Дел нет.')),
                      );
                    } else if (snapshot.hasError) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text('Ошибка: ${snapshot.error}')),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Center(child: Text('Дел нет.')),
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
                        child: ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            final todo = todos[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: switch (index) {
                                  0 => const Radius.circular(8),
                                  _ => Radius.zero,
                                },
                              ),
                              child: TodoTile(todo: todo, todoBloc: todoBloc),
                            );
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
    final newTodo = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewTodoScreen(action: CreateTodo()),
    )) as Todo?;
    if (newTodo != null) {
      todoBloc.addTodo(newTodo);
    }
  }
}

class _MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double collapsedHeight;
  final TodoController todoBloc;

  _MySliverPersistentHeaderDelegate(
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
            child: IconButton(
              padding: EdgeInsets.only(
                right: lerpDouble(24, 18, collapsePercent)!,
                bottom: lerpDouble(0, 16, collapsePercent)!,
              ),
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.remove_red_eye),
              onPressed: () {},
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
