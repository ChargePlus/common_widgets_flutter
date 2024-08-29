import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

/// {@template charge_quota_bar_chart}
/// Bar chart for charge quota
/// {@endtemplate}
class ChargeQuotaBarChart extends StatelessWidget {
  /// {@macro charge_quota_bar_chart}
  const ChargeQuotaBarChart({
    super.key,
    this.title,
    this.titleTrailing,
    this.barChartValue,
    this.subtitleLeading,
    this.subtitleTrailing,
    this.dense,
  });

  /// This property is used for title in the leading of the bar chart
  final Widget? title;

  /// This property is used for title in the trailing of the bar chart
  final Widget? titleTrailing;

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
    final spacing = Breakpoint.fromMediaQuery(context).gutters;

    return ListTile(
      dense: dense,
      // contentPadding: const EdgeInsets.only(
      //   left: 16,
      //   right: 16,
      //   bottom: 8,
      // ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title ?? const SizedBox.shrink(),
          if (titleTrailing != null)
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              child: titleTrailing ?? const SizedBox.shrink(),
            ),
        ],
      ),
      subtitle: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: spacing / 2),
            child: _BarChart(value: barChartValue),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              subtitleLeading ?? const SizedBox.shrink(),
              if (subtitleTrailing != null)
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
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        tween: Tween<double>(
          begin: 0,
          end: value,
        ),
        builder: (context, value, _) =>
            LinearProgressIndicator(minHeight: 30, value: value),
      ),
    );
  }
}
