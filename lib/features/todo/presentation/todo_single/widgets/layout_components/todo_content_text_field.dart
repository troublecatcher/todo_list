import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/l10n/generated/l10n.dart';
import '../../../../../../core/core.dart';
import '../../../../../features.dart';

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
    return CustomCard(
      padding: const EdgeInsets.all(16),
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
        onChanged: (value) =>
            context.read<TodoSingleCubit>().changeText(textController.text),
      ),
    );
  }
}
