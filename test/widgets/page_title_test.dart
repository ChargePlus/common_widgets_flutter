import 'package:common_widgets_flutter/common_widgets_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PageTitle', () {
    testWidgets('renders title only when subtitle null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PageTitle(title: Text('Main Title'))),
        ),
      );

      expect(find.text('Main Title'), findsOneWidget);
      // Subtitle should not be present
      expect(find.text('Sub'), findsNothing);
    });

    testWidgets('renders title and subtitle', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PageTitle(title: Text('Main'), subtitle: Text('Sub')),
          ),
        ),
      );

      expect(find.text('Main'), findsOneWidget);
      expect(find.text('Sub'), findsOneWidget);
    });
  });
}
