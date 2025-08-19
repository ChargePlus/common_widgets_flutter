import 'package:common_widgets_flutter/common_widgets_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CircularLoader', () {
    testWidgets('renders CircularProgressIndicator with default size', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: CircularLoader())),
      );

      final progressFinder = find.byType(CircularProgressIndicator);
      expect(progressFinder, findsOneWidget);

      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(of: progressFinder, matching: find.byType(SizedBox)),
      );
      expect(sizedBox.height, 17);
      expect(sizedBox.width, 17);
    });

    testWidgets('applies custom size and color', (tester) async {
      const customColor = Colors.red;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CircularLoader(height: 25, width: 30, color: customColor),
          ),
        ),
      );

      final progress = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progress.color, customColor);

      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(CircularProgressIndicator),
          matching: find.byType(SizedBox),
        ),
      );
      expect(sizedBox.height, 25);
      expect(sizedBox.width, 30);
    });
  });
}
