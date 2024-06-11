import 'package:flutter/material.dart';

/// Card type
enum CardType {
  /// Original [Card] that do not have any config
  original,

  /// Filled [Card] with colorScheme's surfaceVariant value
  filled,

  /// Outlined [Card] with colorScheme's outline value
  outlined
}

/// {@template section_card}
/// Card for a section that has title
/// {@endtemplate}
class SectionCard extends StatelessWidget {
  /// {@macro section_card}
  const SectionCard({
    required this.title,
    super.key,
    this.margin,
    this.child,
    this.color,
    this.type = CardType.original,
    this.elevation,
    this.spacing = 16,
    this.shape,
  });

  /// This property is used to configure an [Card]'s title.
  final Widget title;

  /// This property is used to configure an [Card]'s margin.
  final EdgeInsetsGeometry? margin;

  /// This property is used to configure an [Card]'s background color.
  final Color? color;

  /// This property is used to configure an [Card]'s child.
  final Widget? child;

  /// This property is used to configure whether the card is original,
  /// filled, outlined.
  ///
  /// [CardType.original], [CardType.filled], [CardType.outlined]
  final CardType type;

  /// This property is used to configure an [Card]'s elevation.
  /// Only available in [CardType.original]
  final double? elevation;

  /// This property is used to configure an [Card]'s spacing.
  final double spacing;

  /// This property is used to configure an [Card]'s shape.
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CardType.original:
        return Card(
          margin: margin,
          elevation: elevation,
          color: color,
          shape: shape,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    spacing,
                    spacing / 2,
                    spacing,
                    spacing,
                  ),
                  child: AnimatedDefaultTextStyle(
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w200,
                        ),
                    duration: const Duration(milliseconds: 200),
                    child: title,
                  ),
                ),
                if (child != null) child!,
              ],
            ),
          ),
        );
      case CardType.filled:
        return Card(
          color: color ??
              Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withOpacity(0.7),
          elevation: 0,
          margin: margin,
          shape: shape,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    spacing,
                    spacing / 2,
                    spacing,
                    spacing,
                  ),
                  child: AnimatedDefaultTextStyle(
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w200,
                        ),
                    duration: const Duration(milliseconds: 200),
                    child: title,
                  ),
                ),
                if (child != null) child!,
              ],
            ),
          ),
        );
      case CardType.outlined:
        return Card(
          elevation: 0,
          shape: shape ??
              RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
          color: color ?? Colors.transparent,
          margin: margin,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    spacing,
                    spacing / 2,
                    spacing,
                    spacing,
                  ),
                  child: AnimatedDefaultTextStyle(
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w200,
                        ),
                    duration: const Duration(milliseconds: 200),
                    child: title,
                  ),
                ),
                if (child != null) child!,
              ],
            ),
          ),
        );
    }
  }
}
