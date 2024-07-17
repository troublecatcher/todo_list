import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features.dart';

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TodoDeleteButton(
                    todo: todo,
                    type: type,
                  ),
                  TodoSaveButton(
                    currentTodo: todo,
                    type: type,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
