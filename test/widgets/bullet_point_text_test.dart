import 'package:common_widgets_flutter/common_widgets_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BulletPointText', () {
    testWidgets('renders bullet marker and text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            // Not const because BulletPointText is not a const constructor.
            body: BulletPointText('Hello world'),
          ),
        ),
      );

      expect(find.text(' • '), findsOneWidget);
      expect(find.text('Hello world'), findsOneWidget);
    });

    testWidgets('renders child dash marker when isChild=true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BulletPointText('Child', isChild: true),
          ),
        ),
      );

      expect(find.text(' - '), findsOneWidget);
      expect(find.text('Child'), findsOneWidget);
    });

    testWidgets('renders nested bullet points', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BulletPointText(
              'Parent',
              bulletPoints: [
                BulletPointText('First child', isChild: true),
                BulletPointText('Second child', isChild: true),
              ],
            ),
          ),
        ),
      );

      // Parent bullet marker and text
      expect(find.text(' • '), findsOneWidget);
      expect(find.text('Parent'), findsOneWidget);

      // Child dash markers (two children)
      expect(find.text(' - '), findsNWidgets(2));
      expect(find.text('First child'), findsOneWidget);
      expect(find.text('Second child'), findsOneWidget);
    });

    testWidgets('applies custom text style to marker and text', (tester) async {
      const customStyle = TextStyle(fontSize: 22, color: Colors.purple);
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BulletPointText('Styled', style: customStyle),
          ),
        ),
      );

      final textWidgets = tester.widgetList<Text>(find.text('Styled'));
      expect(textWidgets.length, 1);
      final styledText = textWidgets.first;
      expect(styledText.style?.fontSize, 22);
      expect(styledText.style?.color, Colors.purple);

      final markerText = tester.widget<Text>(find.text(' • '));
      expect(markerText.style?.fontSize, 22);
      expect(markerText.style?.color, Colors.purple);
    });
  });
}
