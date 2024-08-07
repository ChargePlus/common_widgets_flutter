import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// {@template date_time_picker}
/// A date time picker that returns a date and time
/// {@endtemplate}
class DateTimePicker extends StatefulWidget {
  /// {@macro date_time_picker}
  const DateTimePicker({
    required this.onChanged,
    required this.locale,
    this.enabled = true,
    super.key,
    this.labelText,
    this.suffixIcon,
    this.dateOnly = false,
    this.initialValue,
    this.firstDate,
    this.lastDate,
    this.validator,
    this.focusNode,
  });

  /// Label text in date picker field
  final String? labelText;

  /// Suffix icon for the date picker field
  final Icon? suffixIcon;

  /// If the [enabled] is false then the date time button will be disabled
  final bool enabled;

  /// If [dateOnly] is true then the date picker will only allow user to pick
  /// date
  final bool dateOnly;

  /// The initial date
  final DateTime? initialValue;

  /// The first selectable date
  final DateTime? firstDate;

  /// The last selectable date
  final DateTime? lastDate;

  /// The validator for the date time picker
  final String? Function(String? value)? validator;

  /// Called when the user selects an item.
  final void Function(DateTime? value) onChanged;

  /// Locale for date format display on the field
  final Locale locale;

  /// Date time focus node
  final FocusNode? focusNode;

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  final _controller = TextEditingController();

  DateFormat _dateFormat() {
    return widget.dateOnly
        ? DateFormat.yMMMMd(widget.locale.toString())
        : DateFormat.yMMMMd(widget.locale.toString())
            .addPattern('', ', ')
            .add_jm();
  }

  Future<TimeOfDay?> _selectTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    return pickedTime;
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      locale: widget.locale,
      context: context,
      initialDate: widget.initialValue ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1800),
      lastDate: widget.lastDate ?? DateTime.now(),
    );

    if (pickedDate != null) {
      if (widget.dateOnly == true) {
        setState(() {
          _controller.text = _dateFormat().format(pickedDate);
        });
        widget.onChanged(pickedDate);
      } else {
        final pickedTime = await _selectTime();

        if (pickedTime != null) {
          final pickedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          setState(() {
            _controller.text = _dateFormat().format(pickedDateTime);
          });

          widget.onChanged(pickedDateTime);
        }
      }
    }
  }

  void _handleInitialValue() {
    setState(() {
      _controller.text = _dateFormat().format(
        widget.initialValue ?? DateTime.now(),
      );
    });
    widget.onChanged(
      widget.initialValue ?? DateTime.now(),
    );
  }

  @override
  void initState() {
    _handleInitialValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.enabled ? _selectDate : null,
      child: IgnorePointer(
        child: TextFormField(
          enabled: widget.enabled,
          controller: _controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            labelText: widget.labelText,
            suffixIcon: widget.suffixIcon,
          ),
        ),
      ),
    );
  }
}
