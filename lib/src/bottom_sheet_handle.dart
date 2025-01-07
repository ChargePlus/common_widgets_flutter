import 'package:flutter/material.dart';

/// {@template bottom_sheet_handle}
/// Bottom sheet handle
/// {@endtemplate}
class BottomSheetHandle extends StatelessWidget {
  /// {@macro bottom_sheet_handle}
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Theme.of(context).bottomSheetTheme.dragHandleSize?.width ?? 32,
      height: Theme.of(context).bottomSheetTheme.dragHandleSize?.height ?? 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          (Theme.of(context).bottomSheetTheme.dragHandleSize?.height ?? 4) / 2,
        ),
        color: Theme.of(context)
            .colorScheme
            .onSurfaceVariant
            .withValues(alpha: 0.4),
      ),
    );
  }
}
