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
      child: BlocBuilder<RemoteColorsCubit, RemoteColorsState>(
        builder: (context, colorsState) {
          Color? fillColor;
          Color? sideColor;
          double sideWidth = 2;

          if (colorsState is RemoteColorsLoaded) {
            fillColor = _getFillColor(todo, colorsState, context);
            sideColor = _getSideColor(todo, colorsState, context);
          } else {
            fillColor = _getDefaultFillColor(todo, context);
            sideColor = _getDefaultSideColor(todo, context);
          }

          return Checkbox(
            splashRadius: 0,
            activeColor: context.customColors.green,
            fillColor: fillColor != null
                ? WidgetStateProperty.resolveWith<Color?>((states) => fillColor)
                : null,
            side: BorderSide(
              color: sideColor ?? Colors.transparent,
              width: sideWidth,
            ),
            value: todo.done,
            onChanged: (_) => _changeTodoCompletenessStatus(
              context.read<TodoListBloc>(),
            ),
          );
        },
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

  Color? _getFillColor(
    Todo todo,
    RemoteColorsLoaded colors,
    BuildContext context,
  ) {
    switch (todo.importance) {
      case Importance.important:
        return todo.done
            ? null
            : colors.importantColor?.withOpacity(0.2) ??
                context.customColors.red.withOpacity(0.2);
      case Importance.low:
        return todo.done
            ? null
            : colors.lowColor?.withOpacity(0.2) ??
                context.customColors.orange.withOpacity(0.2);
      case Importance.basic:
        return null;
      default:
        return null;
    }
  }

  Color? _getSideColor(
    Todo todo,
    RemoteColorsLoaded colors,
    BuildContext context,
  ) {
    switch (todo.importance) {
      case Importance.important:
        return colors.importantColor ?? context.customColors.red;
      case Importance.low:
        return colors.lowColor ?? context.customColors.orange;
      case Importance.basic:
        return context.dividerColor;
      default:
        return null;
    }
  }

  Color? _getDefaultFillColor(
    Todo todo,
    BuildContext context,
  ) {
    switch (todo.importance) {
      case Importance.important:
        return todo.done ? null : context.customColors.red.withOpacity(0.2);
      case Importance.low:
        return todo.done ? null : context.customColors.orange.withOpacity(0.2);
      case Importance.basic:
        return null;
      default:
        return null;
    }
  }

  Color? _getDefaultSideColor(
    Todo todo,
    BuildContext context,
  ) {
    switch (todo.importance) {
      case Importance.important:
        return context.customColors.red;
      case Importance.low:
        return context.customColors.orange;
      case Importance.basic:
        return context.dividerColor;
      default:
        return null;
    }
  }
}
