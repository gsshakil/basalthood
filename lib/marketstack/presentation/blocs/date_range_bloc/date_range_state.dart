part of 'date_range_bloc.dart';

abstract class DateRangeState extends Equatable {
  const DateRangeState();
  
  @override
  List<Object> get props => [];
}

class DateRangeInitial extends DateRangeState {}
class DateRangeLoading extends DateRangeState {}
class DateRangeSet extends DateRangeState {}
