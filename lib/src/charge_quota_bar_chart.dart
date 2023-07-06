import 'package:flutter/material.dart';

/// {@template charge_quota_bar_chart}
/// Bar chart for charge quota
/// {@endtemplate}
class ChargeQuotaBarChart extends StatelessWidget {
  /// {@macro charge_quota_bar_chart}
  const ChargeQuotaBarChart({
    super.key,
    this.title,
    this.barChartValue,
    this.subtitleLeading,
    this.subtitleTrailing,
    this.dense,
  });

  /// This property is used for title of the bar chart
  final Widget? title;

  /// This property is used for subtitle in the leading of the bar chart
  final Widget? subtitleLeading;

  /// This property is used for subtitle in the trailing of the bar chart
  final Widget? subtitleTrailing;

  /// This property is used for value of the bar chart
  final double? barChartValue;

  /// This property is used for configuring the text scale of the bar chart
  final bool? dense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: dense,
      contentPadding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 8,
      ),
      title: title != null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: title,
            )
          : title,
      subtitle: Column(
        children: [
          _BarChart(value: barChartValue),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              subtitleLeading ?? const SizedBox.shrink(),
              subtitleTrailing ?? const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart({this.value});

  final double? value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: LinearProgressIndicator(
        minHeight: 10,
        value: value ?? 0,
      ),
    );
  }
}
