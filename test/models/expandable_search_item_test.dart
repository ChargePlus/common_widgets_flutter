import 'dart:convert';

import 'package:common_widgets_flutter/common_widgets_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpandableSearchItem', () {
    test('equality and props', () {
      const a = ExpandableSearchItem(title: 'Title', value: 'value');
      const b = ExpandableSearchItem(title: 'Title', value: 'value');
      expect(a, equals(b));
      expect(a.props, containsAll([a.title, a.value]));
    });

    test('empty constants', () {
      expect(ExpandableSearchItem.empty.isEmpty, isTrue);
      expect(ExpandableSearchItem.empty.isNotEmpty, isFalse);
    });

    test('toJson/fromJson', () {
      const item = ExpandableSearchItem(title: 'Apple', value: 'apple');
      final json = item.toJson();
      expect(json['title'], 'Apple');
      expect(json['value'], 'apple');

      final from = ExpandableSearchItem.fromJson(json);
      expect(from, equals(item));

      // round-trip via string
      final encoded = jsonEncode(json);
      final decoded = jsonDecode(encoded) as Map<String, dynamic>;
      expect(ExpandableSearchItem.fromJson(decoded), equals(item));
    });
  });
}
