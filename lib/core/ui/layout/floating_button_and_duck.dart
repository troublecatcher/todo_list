import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:todo_list/config/connectivity/connectivity_cubit.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/todo_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/layout/todo_list.dart';

class DuckWidget extends StatefulWidget {
  const DuckWidget({
    super.key,
  });

  @override
  State<DuckWidget> createState() => _DuckWidgetState();
}

class _DuckWidgetState extends State<DuckWidget> {
  SMIBool? _tired;
  SMIBool? _hiding;
  SMIBool? _happy;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _tired = controller.findInput<bool>('tired') as SMIBool;
    _hiding = controller.findInput<bool>('hiding') as SMIBool;
    _happy = controller.findInput<bool>('happy') as SMIBool;
  }

  void _toggleTired(bool value) => _tired?.change(value);
  void _toggleHiding(bool value) => _hiding?.change(value);
  void _toggleHappy(bool value) => _happy?.change(value);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        _toggleHappy(state is TodoLoadInProgress);
        return BlocBuilder<ConnectivityCubit, ConnectivityState>(
          builder: (context, state) {
            _toggleTired(state is ConnectivityOffline);
            return BlocBuilder<VisibilityCubit, VisibilityMode>(
              builder: (context, state) {
                _toggleHiding(state == VisibilityMode.undone);
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: CustomButtonBase(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      _toggleHappy(true);
                      await Future<void>.delayed(
                        const Duration(seconds: 2),
                      );
                      _toggleHappy(false);
                    },
                    child: RiveAnimation.asset(
                      'assets/animation/untitled.riv',
                      onInit: _onRiveInit,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
