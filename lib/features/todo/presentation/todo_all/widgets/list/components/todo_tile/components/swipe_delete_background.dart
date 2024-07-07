import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';

class DismissDeleteBackground extends StatelessWidget {
  const DismissDeleteBackground({
    super.key,
    required this.reached,
    required this.progress,
  });

  final bool reached;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.customColors.red,
      alignment: Alignment.centerRight,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 50),
        padding: EdgeInsets.only(
          right: reached
              ? MediaQuery.of(context).size.width / 15 * (10 * progress)
              : (24 * (4 * progress)),
        ),
        child: Icon(Icons.delete, color: context.customColors.white),
      ),
    );
  }
}
