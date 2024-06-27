import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/theme/app_colors.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/bloc/single_todo_cubit.dart';

class TodoPrioritySelectionTile extends StatefulWidget {
  const TodoPrioritySelectionTile({super.key});

  @override
  State<TodoPrioritySelectionTile> createState() =>
      _TodoPrioritySelectionTileState();
}

class _TodoPrioritySelectionTileState extends State<TodoPrioritySelectionTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleTodoCubit, Todo>(
      builder: (context, todo) {
        return Builder(
          builder: (ctx) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Приоритет',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(todo.priority.displayName),
              onTap: () => _onPriorityTileTap(ctx),
            );
          },
        );
      },
    );
  }

  void _onPriorityTileTap(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    _showPriorityMenu(
        context, Offset(offset.dx, offset.dy + renderBox.size.height));
  }

  Future<void> _showPriorityMenu(BuildContext context, Offset offset) async {
    final cubit = context.read<SingleTodoCubit>();
    final selectedPriority = await showMenu<TodoPriority>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        offset.dx + 1,
        offset.dy + 1,
      ),
      items: TodoPriority.values.map((TodoPriority priority) {
        final menuItemStyle = Theme.of(context).textTheme.bodyMedium;
        return PopupMenuItem<TodoPriority>(
          value: priority,
          child: Text(
            priority.displayName,
            style: switch (priority) {
              TodoPriority.none => menuItemStyle,
              TodoPriority.low => menuItemStyle,
              TodoPriority.high =>
                menuItemStyle!.copyWith(color: AppColors.red),
            },
          ),
        );
      }).toList(),
    );
    if (selectedPriority != null) {
      cubit.changePriority(selectedPriority);
    }
  }
}
