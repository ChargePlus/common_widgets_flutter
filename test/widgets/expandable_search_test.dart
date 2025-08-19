import 'package:common_widgets_flutter/common_widgets_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpandableSearch', () {
    testWidgets('smoke test opens and closes search delegate', (tester) async {
      const items = [
        ExpandableSearchItem(title: 'Alpha', value: 'alpha'),
        ExpandableSearchItem(title: 'Beta', value: 'beta'),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ExpandableSearch(searchItems: items)),
        ),
      );

      // Tap to open search
      await tester.tap(find.byType(ExpandableSearch));
      await tester.pumpAndSettle();

      // Search page should show at least one suggestion from history or data
      expect(find.byType(ListTile), findsWidgets);

      // Tap first suggestion
      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      // Back to original widget (TextFormField) present
      expect(
        find.byKey(const Key('searchInput_textFormField')),
        findsOneWidget,
      );
    });
  });
}
