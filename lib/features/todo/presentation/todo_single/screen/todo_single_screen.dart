import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/ui/widget/custom_back_button.dart';
import 'package:todo_list/features/todo/presentation/todo_single/cubit/todo_single_cubit.dart';
import 'package:todo_list/features/todo/presentation/common/todo_intent.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_content_text_field.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_deadline_selection_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/buttons/todo_delete_button.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_importance_selection_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/buttons/todo_save_button.dart';

class TodoSingleScreen extends StatelessWidget {
  final TodoIntent action;
  const TodoSingleScreen({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoSingleCubit(intent: action),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              scrolledUnderElevation: 5,
              leading: const CustomBackButton(),
              actions: [TodoSaveButton(intent: action)],
              pinned: true,
            ),
            const SliverPadding(
              padding: EdgeInsets.only(top: 8, right: 16, left: 16),
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
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 8, right: 16, left: 16),
              sliver: SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TodoDeleteButton(intent: action),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
