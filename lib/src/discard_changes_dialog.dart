import 'package:flutter/material.dart';

/// {@template discard_changes_dialog}
/// An alert dialog for users who tries to navigate away from a form
/// {@endtemplate}
class DiscardChangesDialog extends StatelessWidget {
  /// {@macro discard_changes_dialog}
  const DiscardChangesDialog({
    required this.title,
    required this.content,
    super.key,
    this.cancelButtonLabel = 'Cancel',
    this.discardButtonLabel = 'Discard',
  });

  /// This property is used for title
  final String title;

  /// This property is used for content
  final String content;

  /// This property is used for cancel button label
  final String? cancelButtonLabel;

  /// This property is used for discard button label
  final String? discardButtonLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: [Text(content)],
        ),
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(cancelButtonLabel!.toUpperCase()),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(discardButtonLabel!.toUpperCase()),
        ),
      ],
    );
  }
}
