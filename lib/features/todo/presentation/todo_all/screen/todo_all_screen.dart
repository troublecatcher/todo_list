import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type_provider.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/mobile/mobile_layout.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/tablet/tablet_layout.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/connectivity_indicator.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/layout/todo_list.dart';

class TodoAllScreen extends StatelessWidget {
  const TodoAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutType = LayoutTypeProvider.of(context);
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
                child: switch (layoutType) {
                  LayoutType.mobile => const MobileLayout(),
                  LayoutType.tablet => const TabletLayout(),
                },
              ),
            ],
          ),
        ),
        floatingActionButton: const CreateTodoButton(),
      ),
    );
  }
}
