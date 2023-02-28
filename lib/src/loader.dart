import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// {@template loader}
/// Apply shimmer effect for any widgets
/// {@endtemplate}
class Loader extends StatelessWidget {
  /// {@macro loader}
  const Loader({
    required this.child,
    super.key,
  });

  /// Creates a widget that insets its child.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).dividerColor,
      highlightColor: Theme.of(context).dividerColor.withOpacity(0.5),
      child: child,
    );
  }
}
