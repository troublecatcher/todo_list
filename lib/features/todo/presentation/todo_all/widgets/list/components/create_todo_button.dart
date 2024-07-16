part of '../layout/todo_list.dart';

class CreateTodoButton extends StatelessWidget {
  final LayoutType type;
  const CreateTodoButton({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonBase(
      onPressed: () => switch (type) {
        LayoutType.mobile => context.nav.goToTodoSingle(),
        LayoutType.tablet =>
          context.read<TabletViewCubit>().set(TabletViewNewTodoState()),
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.primary,
        ),
        child: Icon(
          Icons.add,
          color: context.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
