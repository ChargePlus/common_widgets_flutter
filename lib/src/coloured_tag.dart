import 'package:flutter/material.dart';

/// {@template coloured_tag}
/// A coloured tag
/// {@endtemplate}
class ColouredTag extends StatelessWidget {
  /// {@macro coloured_tag}
  const ColouredTag({
    required this.label,
    this.color,
    this.gradient,
    super.key,
  });

  /// This property is used for the text in the coloured tag
  final Widget label;

  /// This property is used for the colour of the coloured tag
  final Color? color;

  /// This property is used for the gradient of the coloured tag
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        gradient: gradient,
      ),
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
