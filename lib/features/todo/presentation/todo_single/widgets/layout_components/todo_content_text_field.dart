import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/custom_card.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';

class TodoContentTextField extends StatefulWidget {
  const TodoContentTextField({super.key});

  @override
  State<TodoContentTextField> createState() => _TodoContentTextFieldState();
}

class _TodoContentTextFieldState extends State<TodoContentTextField> {
  final textController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textController.text = context.read<TodoSingleCubit>().state.text;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoSingleCubit, Todo>(
      builder: (context, todo) {
        return Hero(
          tag: todo.id,
          child: CustomCard(
            padding: const EdgeInsets.all(16),
            child: Material(
              color: Colors.transparent,
              child: TextField(
                key: const Key('todoTextField'),
                controller: textController,
                style: context.textTheme.bodyMedium,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: S.of(context).todoTextfieldPlaceholder,
                  hintStyle: context.textTheme.bodyMedium!
                      .copyWith(color: context.colorScheme.tertiary),
                ),
                minLines: 4,
                maxLines: null,
                onChanged: (value) => context
                    .read<TodoSingleCubit>()
                    .changeText(textController.text),
              ),
            ),
          ),
        );
      },
    );
  }
}
