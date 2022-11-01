part of 'date_range_bloc.dart';

abstract class DateRangeEvent extends Equatable {
  const DateRangeEvent();

  @override
  List<Object> get props => [];
}

class SetDateRange extends DateRangeEvent {
  final DateTimeRange dateRange;

  const SetDateRange({required this.dateRange});
}
