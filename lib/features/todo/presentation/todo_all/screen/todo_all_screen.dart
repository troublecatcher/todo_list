import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/mobile/mobile_layout.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/tablet/tablet_layout.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/connectivity_indicator.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_cubit.dart';

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
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          right: false,
          left: false,
          child: Column(
            children: [
              const ConnectivityIndicator(),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 600) {
                      return const TabletLayout();
                    } else {
                      return const MobileLayout();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
