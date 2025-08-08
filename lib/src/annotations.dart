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
    this.hasNoDiscountTariff = false,
    this.taxAnnotationTranslation,
    this.subscriptionAnnotationTranslation,
    this.serviceFeeAnnotationTranslation,
    this.discountQuotaAnnotationTranslation,
    this.noDiscountTariffAnnotationTranslation,
  });

  /// This property is used to show subscription annotation
  final bool hasSubscription;

  /// This property is used to show tax annotation
  final bool hasTax;

  /// This property is used to show service fee annotation
  final bool hasServiceFee;

  /// This property is used to show plan's discounted quota annotation
  final bool hasDiscountQuota;

  /// This property is used to show no discount tariff annotation
  final bool hasNoDiscountTariff;

  /// This property is used to show translated tax label
  ///
  /// Eg. Before 8% GST
  final Text? taxAnnotationTranslation;

  /// This property is used to show translated subscription label
  ///
  /// Eg. Above charging fees apply after monthly subscription quota is exceeded
  final Text? subscriptionAnnotationTranslation;

  /// This property is used to show translated service fee label
  ///
  /// Eg.
  final Text? serviceFeeAnnotationTranslation;

  /// This property is used to show translated discounted quota label
  final Text? discountQuotaAnnotationTranslation;

  /// This property is used to show translated discount tariff label
  final Text? noDiscountTariffAnnotationTranslation;

  @override
  Widget build(BuildContext context) {
    if (hasTax || hasSubscription || hasServiceFee || hasDiscountQuota) {
      return DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
        textAlign: TextAlign.end,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (hasTax) taxAnnotationTranslation ?? const SizedBox.shrink(),
            if (hasServiceFee)
              serviceFeeAnnotationTranslation ?? const SizedBox.shrink(),
            if (hasSubscription)
              subscriptionAnnotationTranslation ?? const SizedBox.shrink(),
            if (hasDiscountQuota)
              discountQuotaAnnotationTranslation ?? const SizedBox.shrink(),
            if (hasNoDiscountTariff)
              noDiscountTariffAnnotationTranslation ?? const SizedBox.shrink(),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
