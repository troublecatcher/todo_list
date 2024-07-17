import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class TodoSingleScreen extends StatelessWidget {
  final Todo? todo;
  const TodoSingleScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 5,
        leading: const CustomBackButton(),
      ),
      body: SafeArea(
        bottom: false,
        child: TodoInfoLayout(todo: todo),
      ),
    );
  }
}
