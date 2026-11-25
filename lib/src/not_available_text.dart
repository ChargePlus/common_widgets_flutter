import 'package:material_ui/material_ui.dart';

/// {@template not_available_text}
/// Shows [label] as a "not available" placeholder: the surrounding text
/// style in the theme's muted `onSurfaceVariant` colour.
///
/// The style comes from the nearest [DefaultTextStyle], which a [Material]
/// or a [ListTile] slot sets from [ThemeData.textTheme], so the placeholder
/// keeps the theme font and the size of the text around it. Any field the
/// ambient style leaves unset comes from [TextTheme.bodyMedium].
///
/// ```dart
/// ListTile(
///   title: NotAvailableText(label: Text(l10n.notAvailableLabel)),
/// )
/// ```
/// {@endtemplate}
class NotAvailableText extends StatelessWidget {
  /// {@macro not_available_text}
  const NotAvailableText({required this.label, super.key});

  /// The placeholder content, usually a [Text].
  final Widget label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = (theme.textTheme.bodyMedium ?? const TextStyle()).merge(
      DefaultTextStyle.of(context).style,
    );

    return AnimatedDefaultTextStyle(
      style: style.copyWith(color: theme.colorScheme.onSurfaceVariant),
      duration: const Duration(milliseconds: 200),
      child: label,
    );
  }
}
