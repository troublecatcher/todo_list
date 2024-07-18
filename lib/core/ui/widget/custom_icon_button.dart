import 'package:flutter/material.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';

class CustomIconButton extends StatefulWidget {
  final IconData icon;
  final void Function()? onPressed;
  final Color color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? iconSize;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
    this.padding,
    this.margin,
    this.iconSize,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool shrank = false;

  @override
  Widget build(BuildContext context) {
    return CustomButtonBase(
      margin: widget.margin,
      padding: widget.padding,
      onPressed: widget.onPressed,
      child: Icon(
        widget.icon,
        size: widget.iconSize ?? 24,
        color: widget.color,
      ),
    );
  }
}
