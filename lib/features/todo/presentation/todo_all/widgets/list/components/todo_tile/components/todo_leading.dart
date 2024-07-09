part of '../todo_tile.dart';

class TodoLeading extends StatelessWidget {
  final Todo todo;
  const TodoLeading({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonBase(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Checkbox(
        splashRadius: 0,
        activeColor: context.customColors.green,
        fillColor: switch (todo.importance) {
          Importance.important => switch (todo.done) {
              true => null,
              false => WidgetStatePropertyAll(
                  context.customColors.red.withOpacity(.2),
                ),
            },
          Importance.low => switch (todo.done) {
              true => null,
              false => WidgetStatePropertyAll(
                  context.customColors.orange.withOpacity(.2),
                ),
            },
          Importance.basic => null,
        },
        side: switch (todo.importance) {
          Importance.important =>
            BorderSide(color: context.customColors.red, width: 2),
          Importance.low =>
            BorderSide(color: context.customColors.orange, width: 2),
          Importance.basic => BorderSide(color: context.dividerColor, width: 2),
        },
        value: todo.done,
        onChanged: (_) => _changeTodoCompletenessStatus(
          context.read<TodoListBloc>(),
        ),
      ),
    );
  }

  void _changeTodoCompletenessStatus(TodoListBloc bloc) {
    Log.i(
      'trying to change todo ${todo.id} completeness status to ${!todo.done}',
    );
    bloc.add(
      TodoUpdated(
        todo.copyWith(
          done: !todo.done,
          changedAt: DateTime.now(),
        ),
      ),
    );
  }
}
