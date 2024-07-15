import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/mobile/mobile_layout.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/tablet/tablet_layout.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/connectivity_indicator.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/todo_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/layout/todo_list.dart';

class TodoAllScreen extends StatefulWidget {
  const TodoAllScreen({super.key});

  @override
  State<TodoAllScreen> createState() => TodoAllScreenState();
}

class TodoAllScreenState extends State<TodoAllScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisibilityCubit(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final type = MediaQuery.of(context).size.shortestSide > 600
              ? LayoutType.tablet
              : LayoutType.mobile;
          return Scaffold(
            body: SafeArea(
              bottom: false,
              right: false,
              left: false,
              child: Column(
                children: [
                  const ConnectivityIndicator(),
                  Expanded(
                    child: type == LayoutType.tablet
                        ? const TabletLayout()
                        : const MobileLayout(),
                  ),
                ],
              ),
            ),
            floatingActionButton: CreateTodoButton(type: type),
          );
        },
      ),
    );
  }
}
