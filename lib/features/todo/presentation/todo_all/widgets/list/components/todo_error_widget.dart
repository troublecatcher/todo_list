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
      child: Center(
        child: Text(
          S.of(context).errorMessage(message),
        ),
      ),
    );
  }
}
