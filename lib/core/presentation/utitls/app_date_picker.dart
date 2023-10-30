import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class AppDatePicker{

  final List<DateTime?> _dialogCalendarPickerValue = <DateTime>[
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now(),
  ];
   Future<List<DateTime?>?> showDateRangePickerDialog(BuildContext context,
       List<DateTime?>? initialValues) async {
    final List<DateTime?>? results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
      ),
      dialogSize: const Size(325, 400),
      value: initialValues ?? _dialogCalendarPickerValue,
      borderRadius: BorderRadius.circular(15),
    );
    return results;
  }

  Future<TimeOfDay?> showTimePickerDialog(BuildContext context) async{
     final TimeOfDay? time = await showTimePicker(
         context: context,
       initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input
     );
     return time;
  }
}