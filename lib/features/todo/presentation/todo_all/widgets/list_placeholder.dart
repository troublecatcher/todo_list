import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todo_list/core/ui/custom_card.dart';

class ListPlaceholder extends StatelessWidget {
  const ListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> heights = [40, 60, 80];
    const int childCount = 7;
    final Random random = Random();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index != childCount - 1) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: CustomCard.shimmer(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  enabled: true,
                  child: SizedBox(
                    height: heights[random.nextInt(heights.length)],
                  ),
                ),
              );
            } else {
              return const CustomCard.shimmer(
                margin: EdgeInsets.all(16),
                enabled: true,
                child: SizedBox(
                  height: 50,
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
