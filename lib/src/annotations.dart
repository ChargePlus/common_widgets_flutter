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
    this.hasServiceFee = false,
    this.hasDiscountQuota = false,
    this.taxAnnotationTranslation,
    this.subscriptionAnnotationTranslation,
    this.serviceFeeAnnotationTranslation,
    this.discountQuotaAnnotationTranslation,
  });

  /// This property is used to show subscription annotation
  final bool hasSubscription;

  /// This property is used to show tax annotation
  final bool hasTax;

  /// This property is used to show service fee annotation
  final bool hasServiceFee;

  /// This property is used to show plan's discounted quota annotation
  final bool hasDiscountQuota;

  /// This property is used to show translated tax label
  ///
  /// Eg. Before 8% GST
  final String? taxAnnotationTranslation;

  /// This property is used to show translated subscription label
  ///
  /// Eg. Above charging fees apply after monthly subscription quota is exceeded
  final String? subscriptionAnnotationTranslation;

  /// This property is used to show translated service fee label
  ///
  /// Eg.
  final String? serviceFeeAnnotationTranslation;

  /// This property is used to show translated discounted quota label
  final String? discountQuotaAnnotationTranslation;

  @override
  Widget build(BuildContext context) {
    if (hasTax || hasSubscription || hasServiceFee) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TaxType(
            taxAnnotationTranslation: taxAnnotationTranslation,
            hasTax: hasTax,
          ),
          _ServiceFeeAnnotation(
            hasServiceFee: hasServiceFee,
            serviceFeeAnnotationTranslation: serviceFeeAnnotationTranslation,
          ),
          _SubscriptionAnnotation(
            hasSubscription: hasSubscription,
            subscriptionAnnotationTranslation:
                subscriptionAnnotationTranslation,
          ),
          _DiscountQuotaAnnotation(
            hasDiscountQuota: hasDiscountQuota,
            discountQuotaAnnotationTranslation:
                discountQuotaAnnotationTranslation,
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

class _ServiceFeeAnnotation extends StatelessWidget {
  const _ServiceFeeAnnotation({
    required this.serviceFeeAnnotationTranslation,
    this.hasServiceFee = false,
  });

  final bool hasServiceFee;
  final String? serviceFeeAnnotationTranslation;

  @override
  Widget build(BuildContext context) {
    if (hasServiceFee) {
      return Text(
        serviceFeeAnnotationTranslation ?? '',
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

class _DiscountQuotaAnnotation extends StatelessWidget {
  const _DiscountQuotaAnnotation({
    required this.discountQuotaAnnotationTranslation,
    this.hasDiscountQuota = false,
  });

  final bool hasDiscountQuota;
  final String? discountQuotaAnnotationTranslation;

  @override
  Widget build(BuildContext context) {
    if (hasDiscountQuota) {
      return Text(
        discountQuotaAnnotationTranslation ?? '',
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
