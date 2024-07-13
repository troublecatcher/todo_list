import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/main_list.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/custom_header_delegate.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/todo_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/layout/todo_list.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        edgeOffset: 124,
        onRefresh: () async =>
            context.read<TodoListBloc>().add(TodosFetchStarted()),
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomHeaderDelegate(
                expandedHeight: 116,
                collapsedHeight: 56,
              ),
            ),
            const MainList(type: LayoutType.mobile),
          ],
        ),
      ),
      floatingActionButton: const CreateTodoButton(type: LayoutType.mobile),
    );
  }
}
