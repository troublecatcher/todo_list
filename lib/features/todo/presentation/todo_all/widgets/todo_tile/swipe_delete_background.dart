import 'package:flutter/material.dart';
import 'package:todo_list/config/theme/app_colors.dart';

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
      color: AppColors.red,
      alignment: Alignment.centerRight,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 50),
        padding: EdgeInsets.only(
            right: reached
                ? MediaQuery.of(context).size.width / 15 * (10 * progress)
                : (24 * (4 * progress))),
        child: const Icon(Icons.delete, color: AppColors.white),
      ),
    );
  }
}
