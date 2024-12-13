import 'package:flutter/material.dart';

/// {@template circular_loader}
/// Circular Progress Indicator for SnackBar
/// {@endtemplate}
class CircularLoader extends StatelessWidget {
  /// {@macro circular_loader}
  const CircularLoader({super.key, this.height, this.width, this.color});

  /// This property is used for the height of the circular progress indicator
  final double? height;

  /// This property is used for the width of the circular progress indicator
  final double? width;

  /// This property is used for the color of the circular progress indicator
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 17,
      width: width ?? 17,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color,
      ),
    );
  }
}
