part of '../tile/todo_tile.dart';

class DismissDoneBackground extends StatelessWidget {
  final Todo todo;
  final bool reached;
  final double progress;

  const DismissDoneBackground({
    super.key,
    required this.todo,
    required this.reached,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: switch (todo.done) {
        true => context.dividerColor,
        false => context.customColors.green,
      },
      alignment: Alignment.centerLeft,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 50),
        padding: EdgeInsets.only(
          left: reached
              ? MediaQuery.of(context).size.width / 15 * (10 * progress)
              : (24 * (4 * progress)),
        ),
        child: Icon(
          todo.done ? Icons.close_rounded : Icons.check,
          color: context.customColors.white,
        ),
      ),
    );
  }
}
