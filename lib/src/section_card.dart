import 'package:flutter/material.dart';

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
  });

  /// This property is used to configure an [Card]'s title.
  final String title;

  /// This property is used to configure an [Card]'s margin.
  final EdgeInsetsGeometry? margin;

  /// This property is used to configure an [Card]'s child.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.7),
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: AnimatedDefaultTextStyle(
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w200,
                    ),
                duration: const Duration(milliseconds: 200),
                child: Text(title),
              ),
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
