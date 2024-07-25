part of '../tile/todo_tile.dart';

class SyncWidget extends StatefulWidget {
  final bool isBeingProcessed;

  const SyncWidget({
    super.key,
    required this.isBeingProcessed,
  });

  @override
  State<SyncWidget> createState() => _SyncWidgetState();
}

class _SyncWidgetState extends State<SyncWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: AnimatedSwitcher(
        duration: Durations.extralong1,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: widget.isBeingProcessed
            ? AnimatedSize(
                duration: Durations.medium1,
                child: RotationTransition(
                  turns: Tween(begin: 1.0, end: 0.0).animate(_controller),
                  child: Icon(
                    Icons.sync,
                    size: 25,
                    color: context.colorScheme.primary,
                  ),
                ),
              )
            : const SizedBox(
                width: 25,
                height: 25,
              ),
      ),
    );
  }
}
