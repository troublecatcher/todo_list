import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/ui/custom_icon_button.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/done_todo_count_widget.dart';

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double collapsedHeight;

  CustomHeaderDelegate({
    required this.expandedHeight,
    required this.collapsedHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final collapsePercent = shrinkOffset / expandedHeight;
    final currentHeight =
        (1 - collapsePercent) * (expandedHeight - minExtent) + minExtent;
    final double subtitleHeight = 24.0 * (1 - collapsePercent);
    final shadowPercent =
        (collapsePercent >= 0.7) ? (collapsePercent - 0.7) / 0.3 : 0.0;

    return Container(
      height: currentHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: shadowPercent > 0
            ? [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5 * shadowPercent,
                  spreadRadius: 5 * shadowPercent,
                )
              ]
            : [],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: lerpDouble(60, 16, collapsePercent)!,
              bottom: lerpDouble(0, 16, collapsePercent)!,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Мои дела',
                  style: TextStyle(
                    fontSize: lerpDouble(32, 20, collapsePercent),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4 - 4 * collapsePercent),
                AnimatedContainer(
                  duration: Duration.zero,
                  height: subtitleHeight,
                  child: Opacity(
                    opacity: 1 - collapsePercent,
                    child: const DoneTodoCountWidget(),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _ToggleVisibilityButton(collapsePercent: collapsePercent),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _ToggleVisibilityButton extends StatefulWidget {
  const _ToggleVisibilityButton({required this.collapsePercent});

  final double collapsePercent;

  @override
  State<_ToggleVisibilityButton> createState() =>
      _ToggleVisibilityButtonState();
}

class _ToggleVisibilityButtonState extends State<_ToggleVisibilityButton> {
  late VisibilityMode mode;

  @override
  void didChangeDependencies() {
    mode = context.watch<TodoListBloc>().mode;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: switch (mode) {
        VisibilityMode.undone => Icons.visibility,
        VisibilityMode.all => Icons.visibility_off,
      },
      onPressed: () {
        context.read<TodoListBloc>().add(ToggleVisibilityMode());
      },
      color: Theme.of(context).colorScheme.primary,
      margin: EdgeInsets.only(
        right: lerpDouble(24, 0, widget.collapsePercent)!,
        bottom: lerpDouble(0, 6, widget.collapsePercent)!,
      ),
    );
  }
}
