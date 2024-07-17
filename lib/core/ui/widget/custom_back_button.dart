import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/extensions.dart';

import '../ui.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: Icons.close,
      onPressed: () => context.nav.goBack(),
      color: context.colorScheme.onSurface,
    );
  }
}
