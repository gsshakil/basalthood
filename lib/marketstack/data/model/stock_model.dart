import 'package:equatable/equatable.dart';

class StockModel extends Equatable {
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;
  final double adjHigh;
  final double adjLow;
  final double adjClose;
  final double adjOpen;
  final double adjVolume;
  final double splitFactor;
  final double dividend;
  final String symbol;
  final String exchange;
  final String date;

  const StockModel({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.adjHigh,
    required this.adjLow,
    required this.adjClose,
    required this.adjOpen,
    required this.adjVolume,
    required this.splitFactor,
    required this.dividend,
    required this.symbol,
    required this.exchange,
    required this.date,
  });

  StockModel copyWith({
    double? open,
    double? high,
    double? low,
    double? close,
    double? volume,
    double? adjHigh,
    double? adjLow,
    double? adjClose,
    double? adjOpen,
    double? adjVolume,
    double? splitFactor,
    double? dividend,
    String? symbol,
    String? exchange,
    String? date,
  }) {
    return StockModel(
      open: open ?? this.open,
      high: high ?? this.high,
      low: low ?? this.high,
      close: close ?? this.high,
      volume: volume ?? this.volume,
      adjHigh: adjHigh ?? this.adjHigh,
      adjLow: adjLow ?? this.adjLow,
      adjClose: adjClose ?? this.adjClose,
      adjOpen: adjOpen ?? this.adjOpen,
      adjVolume: adjVolume ?? this.adjVolume,
      splitFactor: splitFactor ?? this.splitFactor,
      dividend: dividend ?? this.dividend,
      symbol: symbol ?? this.symbol,
      exchange: exchange ?? this.exchange,
      date: date ?? this.date,
    );
  }

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        open: json["open"] ?? 0,
        high: json["high"] ?? 0,
        low: json["low"] ?? 0,
        close: json["close"] ?? 0,
        volume: json["volume"] ?? 0,
        adjHigh: json["adj_high"] ?? 0,
        adjLow: json["adj_low"] ?? 0,
        adjClose: json["adj_close"] ?? 0,
        adjOpen: json["adj_open"] ?? 0,
        adjVolume: json["adj_volume"] ?? 0,
        splitFactor: json["split_factor"] ?? 0,
        dividend: json["dividend"] ?? 0,
        symbol: json["symbol"] ?? '',
        exchange: json["exchange"] ?? '',
        date: json["date"] ?? '',
      );

  @override
  List<Object?> get props => [
        open,
        high,
        low,
        close,
        volume,
        adjHigh,
        adjLow,
        adjClose,
        adjOpen,
        adjVolume,
        splitFactor,
        dividend,
        symbol,
        exchange,
        date,
      ];
}
