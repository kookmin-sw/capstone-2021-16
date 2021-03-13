import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Widget build(BuildContext context) {
  return Container(
    child: SfCalendar(
      view: CalendarView.day,
      dataSource: _getCalendarDataSource(),
    ),
  );
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

DataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(
      Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(
              Duration(hours: 2)),
          isAllDay: true,
          subject: 'Meeting',
          color: Colors.blue,
          startTimeZone: '',
          endTimeZone: ''
      ));

  return DataSource(appointments);
}