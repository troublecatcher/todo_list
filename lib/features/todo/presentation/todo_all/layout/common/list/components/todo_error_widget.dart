part of '../layout/todo_list.dart';

class TodoErrorWidget extends StatelessWidget {
  final String message;
  const TodoErrorWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 100,
            color: context.colorScheme.primary,
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).errorMessage(message),
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
