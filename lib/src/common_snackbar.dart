import 'package:common_widgets_flutter/src/circular_loader.dart';
import 'package:flutter/material.dart';

/// {@template common_snackbar}
/// A snackbar
/// {@endtemplate}
class CommonSnackbar extends StatelessWidget {
  /// {@macro common_snackbar}
  const CommonSnackbar({
    required this.text,
    super.key,
    this.isLoading = false,
    this.trailing,
  }) : assert(
          isLoading ^ (trailing != null),
          'isLoading can either be true, or trailing cannot be null',
        );

  /// Text shown
  final String text;

  /// Trailing widget
  final Widget? trailing;

  /// Flag to show CircularLoader as trailing
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconTheme = IconTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isLoading)
          IconTheme(
            data: iconTheme.copyWith(color: theme.scaffoldBackgroundColor),
            child: const CircularLoader(),
          ),
        if (trailing != null && !isLoading)
          IconTheme(
            data: iconTheme.copyWith(color: theme.scaffoldBackgroundColor),
            child: trailing!,
          ),
      ],
    );
  }
}
