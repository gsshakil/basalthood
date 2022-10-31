import 'package:basalt_task/core/error/failure.dart';
import 'package:basalt_task/marketstack/data/model/stock_pagination_model.dart';
import 'package:dartz/dartz.dart';

abstract class IMarketStackRepository {
  Future<Either<Failure, StockPaginationModel>> getStockData({required int limit, required int offset});
}
