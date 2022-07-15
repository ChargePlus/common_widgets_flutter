import 'package:flutter/material.dart';

/// {@template or_suggestion_divider}
/// Divider with an "or" label
/// {@endtemplate}
class OrSuggestionDivider extends StatelessWidget {
  /// {@macro or_suggestion_divider}
  const OrSuggestionDivider({
    super.key,
    this.textColor,
    this.dividerColor,
    this.orLabel = 'or',
  });

  /// This property is used to configure textColor.
  final Color? textColor;

  /// This property is used to configure dividerColor.
  final Color? dividerColor;

  /// This property is used to configure label text.
  final String orLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: dividerColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              orLabel,
              style: TextStyle(color: textColor),
            ),
          ),
          Expanded(
            child: Divider(
              color: dividerColor,
            ),
          ),
        ],
      ),
    );
  }
}
