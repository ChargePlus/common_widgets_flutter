import 'package:flutter/material.dart';

/// {@template tax_annotation}
/// Displays tax information
/// {@endtemplate}
class Annotations extends StatelessWidget {
  /// {@macro tax_annotation}
  const Annotations({
    super.key,
    this.hasSubscription = false,
    this.hasTax = false,
    this.hasOneTimeFee = false,
    this.taxAnnotationTranslation,
    this.subscriptionAnnotationTranslation,
    this.oneTimeFeeAnnotationTranslation,
  });

  /// This property is used to show subscription annotation
  final bool hasSubscription;

  /// This property is used to show tax annotation
  final bool hasTax;

  /// This property is used to show one time fee annotation
  final bool hasOneTimeFee;

  /// This property is used to show translated tax label
  ///
  /// Eg. Before 8% GST
  final String? taxAnnotationTranslation;

  /// This property is used to show translated subscription label
  ///
  /// Eg. Above charging fees apply after monthly subscription quota is exceeded
  final String? subscriptionAnnotationTranslation;

  /// This property is used to show translated one time fee label
  ///
  /// Eg.
  final String? oneTimeFeeAnnotationTranslation;

  @override
  Widget build(BuildContext context) {
    if (hasTax || hasSubscription || hasOneTimeFee) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TaxType(
            taxAnnotationTranslation: taxAnnotationTranslation,
            hasTax: hasTax,
          ),
          _SubscriptionAnnotation(
            hasSubscription: hasSubscription,
            subscriptionAnnotationTranslation:
                subscriptionAnnotationTranslation,
          ),
          _OneTimeFeeAnnotation(
            hasOneTimeFee: hasOneTimeFee,
            oneTimeFeeAnnotationTranslation: oneTimeFeeAnnotationTranslation,
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _TaxType extends StatelessWidget {
  const _TaxType({
    required this.taxAnnotationTranslation,
    this.hasTax = false,
  });

  final bool hasTax;
  final String? taxAnnotationTranslation;

  @override
  Widget build(BuildContext context) {
    if (hasTax) {
      return Text(
        taxAnnotationTranslation ?? '',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
        textAlign: TextAlign.end,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _SubscriptionAnnotation extends StatelessWidget {
  const _SubscriptionAnnotation({
    required this.subscriptionAnnotationTranslation,
    this.hasSubscription = false,
  });

  final bool hasSubscription;
  final String? subscriptionAnnotationTranslation;

  @override
  Widget build(BuildContext context) {
    if (hasSubscription) {
      return Text(
        subscriptionAnnotationTranslation ?? '',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
        textAlign: TextAlign.end,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _OneTimeFeeAnnotation extends StatelessWidget {
  const _OneTimeFeeAnnotation({
    required this.oneTimeFeeAnnotationTranslation,
    this.hasOneTimeFee = false,
  });

  final bool hasOneTimeFee;
  final String? oneTimeFeeAnnotationTranslation;

  @override
  Widget build(BuildContext context) {
    if (hasOneTimeFee) {
      return Text(
        oneTimeFeeAnnotationTranslation ?? '',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
        textAlign: TextAlign.end,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
