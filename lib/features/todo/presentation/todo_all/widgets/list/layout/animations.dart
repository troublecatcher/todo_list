import 'package:flutter/material.dart';

class InsertAnimation extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  const InsertAnimation({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1,
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCirc,
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

class RemoveAnimation extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  const RemoveAnimation({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(
        begin: const Offset(-1, 1),
        end: const Offset(0, 0),
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: child,
        ),
      ),
    );
  }
}

class HideAnimation extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  const HideAnimation({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCirc,
      ),
      axisAlignment: -1,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
