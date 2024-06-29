import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_mode.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/fast_todo_creation_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/todo_tile.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todos,
  });

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisibilityCubit, VisibilityMode>(
      builder: (context, mode) {
        List<Todo> maybeModifiedTodos = todos;
        if (mode == VisibilityMode.undone) {
          maybeModifiedTodos = todos.where((todo) => !todo.done).toList();
        }
        return SliverPadding(
          padding: const EdgeInsets.only(top: 16, bottom: 120),
          sliver: AnimationLimiter(
            child: SliverList.separated(
              itemCount: maybeModifiedTodos.length + 1,
              itemBuilder: (context, index) {
                if (index == maybeModifiedTodos.length) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: const SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: FastTodoCreationTile(),
                      ),
                    ),
                  );
                } else {
                  final Todo todo = maybeModifiedTodos[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: TodoTile(todo: todo),
                      ),
                    ),
                  );
                }
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          ),
        );
      },
    );
  }
}
