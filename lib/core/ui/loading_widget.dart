import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final EdgeInsets? padding;
  const LoadingWidget({
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(12),
      child: const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
