import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expandable_search_item.g.dart';

/// {@template expandable_search_item}
/// Expandable Search Item model
///
/// [ExpandableSearchItem.empty] represents an empty/ inactive charging session.
/// {@endtemplate}
@JsonSerializable()
class ExpandableSearchItem extends Equatable {
  /// {@macro expandable_search_item}
  const ExpandableSearchItem({
    required this.title,
    required this.value,
  });

  /// Create a new [ExpandableSearchItem] instance from a map
  factory ExpandableSearchItem.fromJson(Map<String, dynamic> json) =>
      _$ExpandableSearchItemFromJson(json);

  /// The current search item's title.
  final String title;

  /// The current search item's value.
  final String value;

  /// Empty user which represents an unauthenticated user.
  static const empty = ExpandableSearchItem(title: '', value: '');

  /// Convenience getter to determine whether the current search item is empty.
  bool get isEmpty => this == ExpandableSearchItem.empty;

  /// Convenience getter to determine whether the current search item is not
  /// empty.
  bool get isNotEmpty => this != ExpandableSearchItem.empty;

  /// Create a new map from a [ExpandableSearchItem] instance
  Map<String, dynamic> toJson() => _$ExpandableSearchItemToJson(this);

  @override
  List<Object?> get props => [
        title,
        value,
      ];
}
