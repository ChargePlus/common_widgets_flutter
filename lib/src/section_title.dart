import 'package:flutter/material.dart';

/// {@template section_title}
/// Title for a section
/// {@endtemplate}
class SectionTitle extends StatelessWidget {
  /// {@macro section_title}
  const SectionTitle({
    required this.title,
    super.key,
    this.subtitle,
    this.color,
  });

  /// This property is used for a section's title
  final String title;

  /// This property is used for a section's subtitle
  final String? subtitle;

  /// This property is used for the font color
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: subtitle == null,
      title: AnimatedDefaultTextStyle(
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: color ?? Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
        duration: const Duration(milliseconds: 200),
        child: Text(title),
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
    );
  }
}
