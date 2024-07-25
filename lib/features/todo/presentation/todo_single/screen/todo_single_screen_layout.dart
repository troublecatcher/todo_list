import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/buttons/todo_delete_button.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/buttons/todo_save_button.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_content_text_field.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_deadline_selection_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_importance_selection_tile.dart';

class TodoSingleScreenLayout extends StatelessWidget {
  final Todo? todo;

  const TodoSingleScreenLayout({super.key, required this.todo});

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TodoDeleteButton(todo: todo),
                  TodoSaveButton(currentTodo: todo),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
