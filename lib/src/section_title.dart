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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedDefaultTextStyle(
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: color ?? Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
          duration: const Duration(milliseconds: 250),
          child: Text(title),
        ),
        if (subtitle != null)
          AnimatedDefaultTextStyle(
            style: Theme.of(context).textTheme.bodyLarge!,
            duration: const Duration(milliseconds: 250),
            child: Text(subtitle!),
          ),
      ],
    );
  }
}
