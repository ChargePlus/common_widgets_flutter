import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

/// A text widget that displays a single bullet (•) or child dash (-) followed by
/// its content and any nested bullet points.
///
/// This widget is intended to be composed recursively to produce multi-level
/// bullet lists without relying on `ListView` / `ListTile` boilerplate. You can
/// supply child bullet points via the [bulletPoints] list. Child bullet points
/// will automatically render with a dash " - " instead of a bullet " • " when
/// their [isChild] flag is true.
///
/// The layout uses a `Row` with a leading symbol and the text in an `Expanded`
/// column so long lines wrap correctly underneath the text portion rather than
/// the symbol.
///
/// Spacing between nested bullets adapts to the current adaptive scaffold
/// [Breakpoint] margin to keep visual rhythm across form factors.
///
/// Example:
/// ```dart
/// BulletPointText(
///   'Top level bullet',
///   bulletPoints: const [
///     BulletPointText('First child', isChild: true),
///     BulletPointText('Second child', isChild: true),
///   ],
/// );
/// ```
class BulletPointText extends StatelessWidget {
  /// Creates a bullet point line of text.
  ///
  /// [bulletPoint] is the textual content to display for this bullet.
  ///
  /// Provide nested bullet points with [bulletPoints]. When providing nested
  /// points, set their [isChild] flag to true to render them with the dash
  /// marker. This widget does not automatically mutate the children's
  /// [isChild] value so that you retain control over the visual style at each
  /// level.
  ///
  /// Optionally override the default text style using [style]. When [style] is
  /// provided, the leading symbol receives only right padding; otherwise a top
  /// and bottom padding is applied for more generous vertical spacing in lists.
  const BulletPointText(
    this.bulletPoint, {
    this.bulletPoints = const [],
    this.isChild = false,
    this.style,
    super.key,
  });

  /// The textual content for this bullet point line.
  final String bulletPoint;

  /// Optional nested bullet points to render beneath this one.
  final List<BulletPointText> bulletPoints;

  /// Whether this instance is considered a child bullet (rendered with a dash).
  final bool isChild;

  /// Optional override for the text style of both the marker and the text.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final spacing = Breakpoint.activeBreakpointOf(context).margin;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: style != null
              ? const EdgeInsets.only(right: 16)
              : const EdgeInsets.only(top: 4, bottom: 8, right: 24),
          child: Text(
            isChild ? ' - ' : ' • ',
            style: style ?? Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bulletPoint,
                style: style ?? Theme.of(context).textTheme.bodyLarge,
              ),
              if (bulletPoints.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(
                    top: spacing / 2,
                    right: spacing / 2,
                    bottom: spacing / 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: bulletPoints,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
