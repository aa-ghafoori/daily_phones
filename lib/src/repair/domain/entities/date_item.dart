import 'package:equatable/equatable.dart';

class DateItem extends Equatable {
  const DateItem({
    required this.weekDay,
    required this.date,
    required this.hours,
    this.time,
  });

  final String weekDay;
  final String date;
  final String? time;
  final List<DateTime> hours;

  @override
  List<Object?> get props => [weekDay, date, time];
}
