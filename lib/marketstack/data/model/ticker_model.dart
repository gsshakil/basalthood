import 'package:basalt_task/marketstack/data/model/exchange_model.dart';
import 'package:equatable/equatable.dart';

class TickerModel extends Equatable {
  final String name;
  final String symbol;
  final bool hasIntraday;
  final bool hasEod;
  final dynamic country;
  final ExchangeModel stockExchange;

  const TickerModel({
    required this.name,
    required this.symbol,
    required this.hasIntraday,
    required this.hasEod,
    required this.country,
    required this.stockExchange,
  });

  factory TickerModel.fromJson(Map<String, dynamic> json) => TickerModel(
        name: json["name"] ?? '',
        symbol: json["symbol"] ?? '',
        hasIntraday: json["has_intraday"] ?? '',
        hasEod: json["has_eod"] ?? '',
        country: json["country"] ?? '',
        stockExchange: ExchangeModel.fromJson(json["stock_exchange"]),
      );

  @override
  List<Object?> get props => [
        name,
        symbol,
        hasIntraday,
        hasEod,
        country,
        stockExchange,
      ];
}
