import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/ui/custom_icon_button.dart';
import 'package:todo_list/features/todo/presentation/todo_single/cubit/single_todo_cubit.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_content_text_field.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_deadline_selection_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/buttons/todo_delete_button.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_priority_selection_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/buttons/todo_save_button.dart';

class TodoScreen extends StatelessWidget {
  final TodoAction action;
  const TodoScreen({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingleTodoCubit(action: action),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              scrolledUnderElevation: 5,
              leading: CustomIconButton(
                icon: Icons.close,
                onPressed: () => Navigator.of(context).pop(),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              actions: [TodoSaveButton(action: action)],
              pinned: true,
            ),
            const SliverPadding(
              padding: EdgeInsets.only(top: 8, right: 16, left: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    TodoContentTextField(),
                    TodoPrioritySelectionTile(),
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
                  child: TodoDeleteButton(action: action),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
