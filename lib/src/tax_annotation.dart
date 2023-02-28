import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// {@template tax_annotation}
/// Displays tax information
/// {@endtemplate}
class TaxAnnotation extends StatelessWidget {
  /// {@macro tax_annotation}
  const TaxAnnotation({
    super.key,
    this.hasSubscription = false,
    this.hasTax = false,
    this.taxPercentage,
    this.taxType = 'tax',
    this.prefixLabel = 'Before',
    this.subscriptionQuotaAnnotation =
        'Above charging fees apply after monthly subscription quota is'
            ' exceeded',
  });

  /// This property is used to show SubscriptionAnnotation
  final bool hasSubscription;

  /// This property is used to show SubscriptionAnnotation
  final bool hasTax;

  /// This property is used to show tax percentage
  final num? taxPercentage;

  /// This property is used to show tax type
  ///
  /// Eg. GST, VAT
  final String? taxType;

  /// This property is used to show translated label
  final String prefixLabel;

  /// This property is used to show translated label
  final String subscriptionQuotaAnnotation;

  @override
  Widget build(BuildContext context) {
    if (hasTax == true || hasSubscription == true) {
      return ListTile(
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _TaxType(
              taxPercentage: taxPercentage,
              taxType: taxType,
              beforeLabel: prefixLabel,
              hasTax: hasTax,
            ),
            _SubscriptionAnnotation(
              isSubscription: hasSubscription,
              priceApplicableAfterQuotaLabel: subscriptionQuotaAnnotation,
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _TaxType extends StatelessWidget {
  const _TaxType({
    required this.beforeLabel,
    this.taxPercentage,
    this.taxType,
    this.hasTax = false,
  });

  final bool hasTax;
  final num? taxPercentage;
  final String? taxType;
  final String beforeLabel;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat();

    if (hasTax == true) {
      return Text.rich(
        TextSpan(
          text: '*  $beforeLabel',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w100,
              ),
          children: [
            if (taxPercentage != null)
              TextSpan(
                text: ' ${numberFormat.format(taxPercentage)}% ',
              )
            else
              const TextSpan(text: ' '),
            TextSpan(
              text: taxType,
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _SubscriptionAnnotation extends StatelessWidget {
  const _SubscriptionAnnotation({
    required this.isSubscription,
    required this.priceApplicableAfterQuotaLabel,
  });

  final bool isSubscription;
  final String priceApplicableAfterQuotaLabel;

  @override
  Widget build(BuildContext context) {
    if (isSubscription) {
      return Text(
        priceApplicableAfterQuotaLabel,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w100,
            ),
        textAlign: TextAlign.end,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
