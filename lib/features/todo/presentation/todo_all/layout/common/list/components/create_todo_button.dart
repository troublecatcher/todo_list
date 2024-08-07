part of '../layout/todo_list.dart';

class CreateTodoButton extends StatelessWidget {
  const CreateTodoButton({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutType = LayoutTypeProvider.of(context);
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoadInProgress ||
            state is TodoErrorWidget ||
            state is TodoUnauthorized) {
          return const SizedBox.shrink();
        }
        return CustomButtonBase(
          onPressed: () => switch (layoutType) {
            LayoutType.mobile => context.nav.goTodoSingle(),
            LayoutType.tablet => context.read<TabletLayoutCubit>().set(
                  TabletLayoutNewTodoState(),
                ),
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
      },
    );
  }
}
