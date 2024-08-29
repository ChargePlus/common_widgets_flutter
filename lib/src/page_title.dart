import 'package:flutter/material.dart';

/// {@template page_title}
/// Title and subtitle for a new page
/// {@endtemplate}
class PageTitle extends StatelessWidget {
  /// {@macro page_title}
  const PageTitle({
    required this.title,
    super.key,
    this.subtitle,
  });

  /// This property is used to configure an [AppBar]'s title.
  final Widget title;

  /// This property is used to configure an [AppBar]'s subtitle.
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedDefaultTextStyle(
          style: Theme.of(context).textTheme.headlineLarge!,
          duration: const Duration(milliseconds: 250),
          child: title,
        ),
        if (subtitle != null)
          AnimatedDefaultTextStyle(
            style: Theme.of(context).textTheme.bodyLarge!,
            duration: const Duration(milliseconds: 250),
            child: subtitle!,
          ),
      ],
    );
  }
}
