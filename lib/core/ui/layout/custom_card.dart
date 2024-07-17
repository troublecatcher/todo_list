import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/extensions.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 2),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 0),
            blurRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }
}
