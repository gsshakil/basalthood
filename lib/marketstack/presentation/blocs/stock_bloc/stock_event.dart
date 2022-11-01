part of 'stock_bloc.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

class GetStockData extends StockEvent {
  final String symbol;
  final String dateFrom;
  final String dateTo;
  const GetStockData({
    required this.symbol,
    required this.dateFrom,
    required this.dateTo,
  });
}

class GetMoreStockData extends StockEvent {
  final String symbol;
  final String dateFrom;
  final String dateTo;
  const GetMoreStockData({
    required this.symbol,
    required this.dateFrom,
    required this.dateTo,
  });
}
