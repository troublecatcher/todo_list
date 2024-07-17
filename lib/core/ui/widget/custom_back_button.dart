import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/navigation_extension.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/widget/custom_icon_button.dart';

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
