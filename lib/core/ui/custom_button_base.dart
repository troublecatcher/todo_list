import 'package:flutter/material.dart';

class CustomButtonBase extends StatefulWidget {
  final Widget child;
  final Function()? onPressed;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? shrinkFactor;
  const CustomButtonBase({
    super.key,
    required this.child,
    required this.onPressed,
    this.padding,
    this.margin,
    this.shrinkFactor,
  });

  @override
  State<CustomButtonBase> createState() => _CustomButtonBaseState();
}

class _CustomButtonBaseState extends State<CustomButtonBase> {
  bool shrank = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => setState(() {
        if (widget.onPressed != null) {
          shrank = true;
        }
      }),
      onTapUp: (details) => setState(() {
        if (widget.onPressed != null) {
          shrank = false;
        }
      }),
      onTapCancel: () => setState(() {
        if (widget.onPressed != null) {
          shrank = false;
        }
      }),
      onTap: widget.onPressed,
      child: Container(
        padding: widget.padding ?? const EdgeInsets.all(8),
        margin: widget.margin ?? EdgeInsets.zero,
        color: Colors.transparent,
        child: AnimatedScale(
          scale: shrank ? (widget.shrinkFactor ?? 0.8) : 1,
          duration: Durations.short1,
          child: AnimatedOpacity(
            duration: Durations.short1,
            opacity: widget.onPressed != null ? (shrank ? 0.5 : 1) : 0.5,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
