import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/ui/custom_card.dart';
import 'package:todo_list/features/todo/presentation/todo_single/bloc/single_todo_cubit.dart';

class TodoContentTextField extends StatefulWidget {
  const TodoContentTextField({super.key});

  @override
  State<TodoContentTextField> createState() => _TodoContentTextFieldState();
}

class _TodoContentTextFieldState extends State<TodoContentTextField> {
  final contentController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    contentController.text = context.read<SingleTodoCubit>().state.content!;
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: contentController,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: 'Что надо сделать...',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.tertiary),
        ),
        minLines: 4,
        maxLines: null,
        onChanged: (value) => context
            .read<SingleTodoCubit>()
            .changeContent(contentController.text),
      ),
    );
  }
}
