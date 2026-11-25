import 'package:common_widgets_flutter/common_widgets_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const _themeFont = 'ThemeFont';

TextStyle _renderedStyle(WidgetTester tester, Finder text) {
  final richText = tester.widget<RichText>(
    find.descendant(of: text, matching: find.byType(RichText)),
  );
  return richText.text.style!;
}

void main() {
  group('NotAvailableText', () {
    testWidgets('renders provided label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NotAvailableText(label: Text('N/A'))),
        ),
      );

      expect(find.text('N/A'), findsOneWidget);
    });

    testWidgets('matches the surrounding text, in the muted colour', (
      tester,
    ) async {
      final theme = ThemeData(fontFamily: _themeFont);
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Column(
              children: [
                Text('body'),
                NotAvailableText(label: Text('body N/A')),
                ListTile(title: Text('title')),
                ListTile(title: NotAvailableText(label: Text('title N/A'))),
              ],
            ),
          ),
        ),
      );

      for (final (sibling, placeholder) in [
        ('body', 'body N/A'),
        ('title', 'title N/A'),
      ]) {
        final expected = _renderedStyle(tester, find.text(sibling));
        final actual = _renderedStyle(tester, find.text(placeholder));

        expect(actual.fontFamily, _themeFont);
        expect(actual.fontSize, expected.fontSize);
        expect(actual.fontWeight, expected.fontWeight);
        expect(actual.height, expected.height);
        expect(actual.color, theme.colorScheme.onSurfaceVariant);
      }
    });

    testWidgets('falls back to the theme body style outside Material', (
      tester,
    ) async {
      late ThemeData theme;
      await tester.pumpWidget(
        Theme(
          data: ThemeData(fontFamily: _themeFont),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (context) {
                theme = Theme.of(context);
                return const NotAvailableText(label: Text('N/A'));
              },
            ),
          ),
        ),
      );

      final actual = _renderedStyle(tester, find.text('N/A'));
      expect(actual.fontFamily, _themeFont);
      expect(actual.fontSize, theme.textTheme.bodyMedium!.fontSize);
      expect(actual.fontSize, isNotNull);
      expect(actual.color, theme.colorScheme.onSurfaceVariant);
    });
  });
}
