import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../../config/l10n/generated/l10n.dart';
import '../../../../../../../core/core.dart';
import '../../../../../../features.dart';

part '../components/create_todo_button.dart';
part '../components/fast_todo_creation_tile.dart';
part '../components/no_todos_placeholder.dart';
part '../components/todo_error_widget.dart';

class TodoList extends StatefulWidget {
  final List<Todo> todos;

  const TodoList({super.key, required this.todos});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final Duration _animationDuration = Durations.medium2;
  final _key = GlobalKey<SliverAnimatedListState>();
  late List<Todo> _todos;
  List<Todo> _displayedTodos = [];

  @override
  void initState() {
    super.initState();
    _todos = List.from(widget.todos);
    _displayedTodos = List.from(widget.todos);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoOperationCubit, TodoOperationState>(
      listener: (context, state) => _handleTodoOperations(state),
      child: BlocBuilder<VisibilityCubit, VisibilityMode>(
        builder: (context, mode) {
          _filterTodos(mode);
          return SliverPadding(
            padding: const EdgeInsets.only(top: 16, bottom: 120),
            sliver: AnimationLimiter(
              child: SliverAnimatedList(
                key: _key,
                initialItemCount: _displayedTodos.length + 1,
                itemBuilder: (context, index, animation) {
                  if (index == _displayedTodos.length) {
                    return _StaggeredAnimationWrapper(
                      index: index,
                      child: const FastTodoCreationTile(),
                    );
                  } else {
                    final Todo todo = _displayedTodos[index];
                    return _StaggeredAnimationWrapper(
                      index: index,
                      child: InsertAnimation(
                        animation: animation,
                        child: TodoTile(todo: todo),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _filterTodos(VisibilityMode mode) {
    if (mode == VisibilityMode.undone) {
      for (int i = _displayedTodos.length - 1; i >= 0; i--) {
        if (_displayedTodos[i].done) {
          final removedTodo = _displayedTodos.removeAt(i);
          _key.currentState?.removeItem(
            i,
            (context, animation) => HideAnimation(
              animation: animation,
              child: TodoTile(todo: removedTodo),
            ),
            duration: _animationDuration,
          );
        }
      }
    } else {
      for (int i = 0; i < _todos.length; i++) {
        if (!_displayedTodos.contains(_todos[i])) {
          _displayedTodos.insert(i, _todos[i]);
          _key.currentState?.insertItem(i, duration: _animationDuration);
        }
      }
    }
  }

  void _handleTodoOperations(TodoOperationState state) {
    if (state is TodoOperationProcessingState) {
      switch (state.type) {
        case TodoOperationType.create:
          _addTodoToList(state.todo);
          break;
        case TodoOperationType.update:
          _updateTodoInList(state.todo);
          break;
        case TodoOperationType.delete:
          _removeTodoFromList(state.todo);
          break;
      }
    }
  }

  void _addTodoToList(Todo todo) {
    _todos.add(todo);
    if (_shouldDisplay(todo)) {
      _displayedTodos.add(todo);
      _key.currentState?.insertItem(
        _displayedTodos.length - 1,
        duration: _animationDuration,
      );
    }
  }

  void _updateTodoInList(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      final displayedIndex = _displayedTodos.indexWhere((t) => t.id == todo.id);
      if (_shouldDisplay(todo)) {
        if (displayedIndex == -1) {
          _displayedTodos.add(todo);
          _key.currentState?.insertItem(
            _displayedTodos.length - 1,
            duration: _animationDuration,
          );
        } else {
          _displayedTodos[displayedIndex] = todo;
          setState(() {});
        }
      } else {
        if (displayedIndex != -1) {
          final removedTodo = _displayedTodos.removeAt(displayedIndex);
          _key.currentState?.removeItem(
            displayedIndex,
            (context, animation) => UpdateAnimation(
              animation: animation,
              child: TodoTile(todo: removedTodo),
            ),
            duration: _animationDuration,
          );
        }
      }
    }
  }

  void _removeTodoFromList(Todo todo) {
    final index = _todos.indexOf(todo);
    if (index != -1) {
      final removedTodo = _todos.removeAt(index);
      final displayedIndex = _displayedTodos.indexOf(todo);
      if (displayedIndex != -1) {
        _key.currentState?.removeItem(
          displayedIndex,
          (context, animation) => RemoveAnimation(
            animation: animation,
            child: TodoTile(todo: removedTodo),
          ),
          duration: _animationDuration,
        );
        _displayedTodos.removeAt(displayedIndex);
      }
    }
  }

  bool _shouldDisplay(Todo todo) {
    final visibilityMode = context.read<VisibilityCubit>().state;
    return visibilityMode != VisibilityMode.undone || !todo.done;
  }
}

class _StaggeredAnimationWrapper extends StatelessWidget {
  final int index;
  final Widget child;
  const _StaggeredAnimationWrapper({
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
