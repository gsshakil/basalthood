import 'package:basalt_task/marketstack/data/model/stock_pagination_model.dart';
import 'package:basalt_task/marketstack/data/model/ticker_pagination_model.dart';

abstract class IMarketStackDataSource {
  Future<StockPaginationModel> getStockData({
    required int limit,
    required int offset,
    required String dateFrom,
    required String dateTo,
    required String symbol,
  });

  Future<TickerPaginationModel> getTickerData();
}
