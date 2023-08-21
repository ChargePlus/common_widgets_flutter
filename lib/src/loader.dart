import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// {@template loader}
/// Apply shimmer effect for any widgets
/// {@endtemplate}
class Loader extends StatelessWidget {
  /// {@macro loader}
  const Loader({
    required this.child,
    this.color,
    super.key,
  });

  /// Creates a widget that insets its child.
  final Widget child;

  /// Color of the shimmer effect
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Animate(
      onPlay: (controller) => controller.repeat(),
      effects: [
        TintEffect(color: Colors.grey.shade700),
        ShimmerEffect(
          duration: 1200.ms,
          color: color ??
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
        ),
      ],
      child: child,
    );
  }
}
