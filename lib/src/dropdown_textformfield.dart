import 'package:flutter/material.dart';

/// {@template dropdown_field}
/// A dropdown field with input decorator
/// {@endtemplate}
class DropdownTextFormField<T> extends StatelessWidget {
  /// {@macro dropdown_field}
  const DropdownTextFormField({
    super.key,
    this.labelText,
    this.helperText,
    required this.items,
    required this.onChanged,
    required this.value,
    this.enabled = true,
    this.focusNode,
    this.decoration,
    this.errorText,
    this.icon,
  });

  /// Label text in dropdown field
  final String? labelText;

  /// Helper text in dropdown field
  final String? helperText;

  /// The list of items the user can select.
  /// If the [onChanged] callback is null or the list of items is null then
  /// the dropdown button will be disabled
  final List<DropdownMenuItem<T>> items;

  /// Called when the user selects an item.
  final ValueSetter<T?> onChanged;

  /// The value of the currently selected [DropdownMenuItem].
  final T? value;

  /// If the [enabled] is false then the dropdown button will be disabled
  final bool enabled;

  /// Dropdown focus node
  final FocusNode? focusNode;

  /// The text and styles to use when decorating the dropdown field
  final InputDecoration? decoration;

  /// Error text in dropdown field
  final String? errorText;

  /// Icon for dropdown icon
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: decoration != null
          ? decoration!.copyWith(
              labelText: labelText,
              helperText: helperText,
              errorText: errorText,
            )
          : InputDecoration(
              labelText: labelText,
              helperText: helperText,
              errorText: errorText,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 12,
              ),
            ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          focusNode: focusNode,
          value: value,
          onChanged: enabled ? onChanged : null,
          items: items,
          icon: icon,
        ),
      ),
    );
  }
}
