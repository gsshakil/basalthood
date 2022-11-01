part of 'ticker_bloc.dart';

abstract class TickerState extends Equatable {
  const TickerState();

  @override
  List<Object> get props => [];
}

class TickerInitial extends TickerState {}

class TickerLoading extends TickerState {}

class TickerMoreLoading extends TickerState {}

class TickerError extends TickerState {
  final String error;
  const TickerError({required this.error});
}

class TickerSuccess extends TickerState {
  final List<TickerModel> tickerData;

  const TickerSuccess({required this.tickerData});
}
