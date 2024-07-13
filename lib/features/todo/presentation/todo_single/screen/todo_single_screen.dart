import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/ui/widget/custom_back_button.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/todo_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_single/screen/todo_info_layout.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_content_text_field.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_deadline_selection_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/buttons/todo_delete_button.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/layout_components/todo_importance_selection_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/widgets/buttons/todo_save_button.dart';

class TodoSingleScreen extends StatelessWidget {
  final Todo? todo;
  const TodoSingleScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 5,
        leading: const CustomBackButton(),
      ),
      body: SafeArea(
        bottom: false,
        child: TodoInfoLayout(
          todo: todo,
          type: LayoutType.mobile,
        ),
      ),
    );
  }
}
