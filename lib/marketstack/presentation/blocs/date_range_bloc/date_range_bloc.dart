// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'date_range_event.dart';
part 'date_range_state.dart';

class DateRangeBloc extends Bloc<DateRangeEvent, DateRangeState> {
  DateTimeRange _dateRange = DateTimeRange(
    start: DateTime(2022, 10, 31),
    end: DateTime.now(),
  );

  DateTimeRange get dateRange => _dateRange;

  DateRangeBloc() : super(DateRangeInitial()) {
    on<SetDateRange>((event, emit) async {
      emit(DateRangeLoading());
      _dateRange = event.dateRange;
      emit(DateRangeSet());
    });
  }
}
