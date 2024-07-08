import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todo_list/core/ui/layout/app_shimmer.dart';
import 'package:todo_list/core/ui/layout/custom_card.dart';

class TodoShimmerList extends StatelessWidget {
  const TodoShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> heights = [40, 60, 80];
    const int childCount = 8;
    final Random random = Random();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index != childCount - 1) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CustomCard(
                  child: AppShimmer(
                    enabled: true,
                    child: SizedBox(
                      height: heights[random.nextInt(heights.length)],
                    ),
                  ),
                ),
              );
            } else {
              return const CustomCard(
                margin: EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 50,
                  child: AppShimmer(enabled: true, child: SizedBox.shrink()),
                ),
              );
            }
          },
          childCount: childCount,
        ),
      ),
    );
  }
}
