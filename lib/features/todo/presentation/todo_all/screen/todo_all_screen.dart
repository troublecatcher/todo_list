import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features.dart';

class TodoAllScreen extends StatelessWidget {
  const TodoAllScreen({super.key});

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
