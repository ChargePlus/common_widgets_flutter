import 'package:flutter/material.dart';

/// {@template coloured_tag}
/// A coloured tag
/// {@endtemplate}
class ColouredTag extends StatelessWidget {
  /// {@macro coloured_tag}
  const ColouredTag({
    required this.label,
    required this.color,
    this.secondColor,
    super.key,
  });

  /// This property is used for the text in the coloured tag
  final Widget label;

  /// This property is used for the colour of the coloured tag
  final Color color;

  /// This property is used for the second colour of the coloured tag
  final Color? secondColor;

  @override
  Widget build(BuildContext context) {
    final gradient = [
      color,
      color,
      secondColor ?? Colors.transparent,
      secondColor ?? Colors.transparent,
    ];

    final stops = [0.0, 0.5, 0.5, 1.0];

    final decoration = secondColor != null
        ? BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(colors: gradient, stops: stops),
          )
        : BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: decoration,
      child: AnimatedDefaultTextStyle(
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(fontWeight: FontWeight.w600),
        duration: const Duration(milliseconds: 200),
        child: label,
      ),
    );
  }
}
