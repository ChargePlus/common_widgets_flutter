import 'package:common_widgets_flutter/common_widgets_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
  });
}
