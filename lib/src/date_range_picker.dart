import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// {@template date_range_picker}
/// A date range picker that returns start date and time, end date and time
/// {@endtemplate}
class DateRangePicker extends StatefulWidget {
  /// {@macro date_range_picker}
  const DateRangePicker({
    required this.onChanged,
    super.key,
    this.initialDateRange,
    this.decoration,
    this.labelText,
    this.helperText,
    this.saveText,
    this.enabled = true,
    this.locale,
    this.backgroundColor,
  });

  /// The initial date range
  final DateTimeRange? initialDateRange;

  /// The text and styles to use when decorating the date time range picker
  final InputDecoration? decoration;

  /// Label text in date picker field
  final String? labelText;

  /// Helper text in date picker field
  final String? helperText;

  /// Text in date picker field save button
  final String? saveText;

  /// If the [enabled] is false then the date time button will be disabled
  final bool enabled;

  /// Called when the user selects a date time range.
  final void Function(DateTimeRange?) onChanged;

  /// Locale for date format display on the field
  final Locale? locale;

  /// Background color of the date time range picker
  final Color? backgroundColor;

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  final controller = TextEditingController();

  Future<void> _showDateRangePicker(DateFormat dateFormat) async {
    final pickedRange = await showDateRangePicker(
      context: context,
      initialDateRange: widget.initialDateRange,
      currentDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      saveText: widget.saveText,
      locale: widget.locale,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            appBarTheme: AppBarTheme(
              backgroundColor: widget.backgroundColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedRange != null) {
      final pickedStartDate = pickedRange.start;
      final pickedEndDate = pickedRange.end;
      final updatedEndDate = DateTime(
        pickedEndDate.year,
        pickedEndDate.month,
        pickedEndDate.day,
        23,
        59,
        59,
      );
      final formattedStartDate = dateFormat.format(pickedStartDate);
      final formattedEndDate = dateFormat.format(updatedEndDate);

      setState(() {
        controller.text = '$formattedStartDate — $formattedEndDate';
      });

      // Return value
      widget.onChanged(
        DateTimeRange(start: pickedStartDate, end: updatedEndDate),
      );
    }
  }

  void _handleInitialDateValue(DateFormat dateFormat) {
    if (widget.initialDateRange != null) {
      final formattedStartDate =
          dateFormat.format(widget.initialDateRange!.start);
      final formattedEndDate = dateFormat.format(widget.initialDateRange!.end);

      setState(() {
        controller.text = '$formattedStartDate — $formattedEndDate';
      });
    } else {
      setState(() {
        controller.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd('${widget.locale}');

    _handleInitialDateValue(dateFormat);
    return InkWell(
      onTap: widget.enabled == true
          ? () => _showDateRangePicker(dateFormat)
          : null,
      child: IgnorePointer(
        child: TextFormField(
          controller: controller,
          decoration: widget.decoration != null
              ? widget.decoration!.copyWith(
                  labelText: widget.labelText,
                  helperText: widget.helperText,
                )
              : InputDecoration(
                  labelText: widget.labelText,
                  helperText: widget.helperText,
                  suffixIcon: const Icon(Icons.date_range_outlined),
                ),
        ),
      ),
    );
  }
}
