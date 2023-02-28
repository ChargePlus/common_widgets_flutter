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
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: AnimatedDefaultTextStyle(
        style: Theme.of(context).textTheme.titleLarge!,
        duration: const Duration(milliseconds: 200),
        child: title,
      ),
      subtitle: subtitle,
    );
  }
}
