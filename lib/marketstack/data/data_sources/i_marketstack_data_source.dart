import 'package:basalt_task/marketstack/data/model/stock_pagination_model.dart';

abstract class IMarketStackDataSource {
  Future<StockPaginationModel> getStockData({required int limit, required int offset});
}
