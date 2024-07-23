import 'package:flutter/material.dart';

/// {@template not_available_text}
/// Not available text
/// {@endtemplate}
class NotAvailableText extends StatelessWidget {
  /// {@macro not_available_text}
  const NotAvailableText({
    required this.label,
    super.key,
  });

  /// This property is used for a not available text
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      duration: const Duration(milliseconds: 200),
      child: label,
    );
  }
}
