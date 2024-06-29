import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

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
        color: Theme.of(context).colorScheme.surface,
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
              child: Shimmer(
                duration: const Duration(seconds: 3),
                interval: const Duration(seconds: 5),
                color: Theme.of(context).colorScheme.primary,
                enabled: shimmerEnabled,
                direction: const ShimmerDirection.fromLeftToRight(),
                child: cardContent,
              ),
            )
          : cardContent,
    );
  }
}
