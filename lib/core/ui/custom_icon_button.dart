import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final IconData icon;
  final Function()? onPressed;
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
    return GestureDetector(
      onTapDown: (details) => setState(() => shrank = true),
      onTapUp: (details) => setState(() => shrank = false),
      onTapCancel: () => setState(() => shrank = false),
      onTap: widget.onPressed,
      child: Opacity(
        opacity: widget.onPressed == null ? 0.5 : 1,
        child: Container(
          // workaround to make area around icon
          // clickable aswell
          padding: widget.padding ?? const EdgeInsets.all(8),
          margin: widget.margin ?? EdgeInsets.zero,
          color: Colors.transparent,
          child: AnimatedScale(
            scale: shrank ? 0.8 : 1,
            duration: Durations.short1,
            child: AnimatedOpacity(
              duration: Durations.short1,
              opacity: shrank ? 0.8 : 1,
              child: Icon(
                widget.icon,
                size: widget.iconSize ?? 24,
                color: widget.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
