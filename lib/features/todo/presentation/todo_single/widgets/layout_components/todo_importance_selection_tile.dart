import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';

class TodoImportanceSelectionTile extends StatefulWidget {
  const TodoImportanceSelectionTile({super.key});

  @override
  State<TodoImportanceSelectionTile> createState() =>
      _TodoImportanceSelectionTileState();
}

class _TodoImportanceSelectionTileState
    extends State<TodoImportanceSelectionTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoSingleCubit, TodoEntity>(
      builder: (context, todo) {
        return Builder(
          builder: (ctx) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                S.of(context).todoImportance,
                style: context.textTheme.bodyMedium,
              ),
              subtitle: Text(
                Intl.message(
                  todo.importance.name,
                  name: 'todoImportance_${todo.importance.name}',
                ),
              ),
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
      context,
      Offset(offset.dx, offset.dy + renderBox.size.height),
    );
  }

  Future<void> _showPriorityMenu(BuildContext context, Offset offset) async {
    final cubit = context.read<TodoSingleCubit>();
    final selectedPriority = await showMenu<Importance>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        offset.dx + 1,
        offset.dy + 1,
      ),
      items: Importance.values.map(
        (Importance importance) {
          final menuItemStyle = context.textTheme.bodyMedium;
          return PopupMenuItem<Importance>(
            value: importance,
            child: Text(
              Intl.message(
                importance.name,
                name: 'todoImportance_${importance.name}',
              ),
              style: switch (importance) {
                Importance.basic => menuItemStyle,
                Importance.low => menuItemStyle,
                Importance.important =>
                  menuItemStyle!.copyWith(color: context.customColors.red),
              },
            ),
          );
        },
      ).toList(),
    );
    if (selectedPriority != null) {
      cubit.changeImportance(selectedPriority);
    }
  }
}
