import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/build_context_extension.dart';
import 'package:todo_list/core/ui/app_shimmer.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool shimmerEnabled;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  }) : shimmerEnabled = false;

  const CustomCard.shimmer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    required bool enabled,
  }) : shimmerEnabled = enabled;

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
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

    return Container(
      margin: margin,
      child: shimmerEnabled
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppShimmer(
                enabled: shimmerEnabled,
                child: cardContent,
              ),
            )
          : cardContent,
    );
  }
}
