import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:todo_list/core/extensions/build_context_extension.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;
  final bool enabled;
  const AppShimmer({
    super.key,
    required this.child,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Shimmer(
        duration: const Duration(seconds: 3),
        interval: const Duration(seconds: 5),
        color: context.colorScheme.primary,
        enabled: enabled,
        direction: const ShimmerDirection.fromLeftToRight(),
        child: child,
      ),
    );
  }
}
