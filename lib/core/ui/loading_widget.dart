import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
