import 'package:flutter/material.dart';

/// {@template bottom_sheet_handle}
/// Bottom sheet handle
/// {@endtemplate}
class BottomSheetHandle extends StatelessWidget {
  /// {@macro bottom_sheet_handle}
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: MediaQuery.of(context).size.width / 2.5,
      thickness: 3,
      endIndent: MediaQuery.of(context).size.width / 2.5,
    );
  }
}
