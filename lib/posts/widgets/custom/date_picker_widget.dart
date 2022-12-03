import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/utils/date_constants.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime? dateInput;
  final String labelText;
  final DateTime? initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final bool isRequired;
  final String? validationText;
  final void Function(dynamic)? onSaved;
  final void Function(dynamic)? onChanged;

  const DatePickerWidget({
    Key? key,
    required this.dateInput,
    required this.labelText,
    required this.readOnly,
    required this.decoration,
    required this.isRequired,
    required this.validationText,
    required this.onSaved,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final dayMonthYearFormat = DateFormat(DateConstants.DAY_MONTH_YEAR);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      resetIcon: null,
      cursorColor: colorPrimary,
      format: dayMonthYearFormat,
      decoration: widget.decoration,
      keyboardType: TextInputType.datetime,
      onShowPicker: (context, currentValue) async {
        if (widget.readOnly) {
          return widget.initialValue;
        } else {
          final date = showDatePicker(
            context: context,
            initialDate: widget.dateInput ?? DateTime.now(),
            errorFormatText: 'Enter valid date',
            errorInvalidText: 'Enter date in valid range',
            firstDate: DateTime(2000),
            lastDate: DateTime(2050),
          );
          return date;
        }
      },
      initialValue: widget.initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      validator: (value) {
        if (value == null && widget.isRequired) {
          return widget.validationText;
        }
        return null;
      },
    );
  }
}
