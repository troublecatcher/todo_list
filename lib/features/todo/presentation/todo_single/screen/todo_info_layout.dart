import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/todo_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/buttons/todo_delete_button.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/buttons/todo_save_button.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_content_text_field.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_deadline_selection_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_importance_selection_tile.dart';

class TodoInfoLayout extends StatelessWidget {
  final Todo? todo;
  final LayoutType type;

  const TodoInfoLayout({
    super.key,
    required this.todo,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoSingleCubit(todo: todo),
      child: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.only(top: 16, right: 16, left: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  TodoContentTextField(),
                  TodoImportanceSelectionTile(),
                  Divider(height: 0),
                  TodoDeadlineSelectionTile(),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Divider()),
          SliverToBoxAdapter(
            child: TodoSaveButton(
              currentTodo: todo,
              type: type,
            ),
          ),
          const SliverToBoxAdapter(child: Divider()),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 32, right: 16, left: 16),
            sliver: SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TodoDeleteButton(
                  todo: todo,
                  type: type,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
