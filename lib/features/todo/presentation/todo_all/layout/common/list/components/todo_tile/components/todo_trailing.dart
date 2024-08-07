part of '../tile/todo_tile.dart';

class TodoTrailing extends StatelessWidget {
  final Todo todo;

  const TodoTrailing({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          bottom: 16,
        ),
        child: Icon(
          Icons.arrow_back_ios,
          color: context.dividerColor,
        ),
      ),
    );
  }
}
