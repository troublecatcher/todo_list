part of '../layout/todo_list.dart';

class NoTodosPlaceholder extends StatelessWidget {
  const NoTodosPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.done_all_rounded,
            size: 100,
            color: context.colorScheme.primary,
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).noTodos,
            style: context.textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            S.of(context).luckyYou,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
