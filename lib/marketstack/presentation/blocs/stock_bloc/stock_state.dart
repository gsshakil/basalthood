part of 'stock_bloc.dart';

abstract class StockState extends Equatable {
  const StockState();

  @override
  List<Object> get props => [];
}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockMoreLoading extends StockState {}

class StockError extends StockState {
  final String error;
  const StockError({required this.error});
}

class StockSuccess extends StockState {
  final List<StockModel> stockData;

  const StockSuccess({required this.stockData});
}
