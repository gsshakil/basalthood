import 'package:basalt_task/core/error/exceptions.dart';
import 'package:basalt_task/marketstack/data/data_sources/i_marketstack_data_source.dart';
import 'package:basalt_task/core/error/failure.dart';
import 'package:basalt_task/marketstack/data/model/stock_pagination_model.dart';
import 'package:basalt_task/marketstack/data/model/ticker_pagination_model.dart';
import 'package:basalt_task/marketstack/domain/repositories/i_market_stack_repository.dart';
import 'package:dartz/dartz.dart';

class MarketStackRepository implements IMarketStackRepository {
  IMarketStackDataSource marketStackDataSource;
  MarketStackRepository({required this.marketStackDataSource});

  @override
  Future<Either<Failure, StockPaginationModel>> getStockData({
    required int limit,
    required int offset,
    required String dateFrom,
    required String dateTo,
    required String symbol,
  }) async {
    try {
      StockPaginationModel result = await marketStackDataSource.getStockData(
        limit: limit,
        offset: offset,
        dateFrom: dateFrom,
        dateTo: dateTo,
        symbol: symbol,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.errorMessage, code: e.code));
    }
  }

  @override
  Future<Either<Failure, TickerPaginationModel>> getTickerData() async {
    try {
      TickerPaginationModel result =
          await marketStackDataSource.getTickerData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.errorMessage, code: e.code));
    }
  }
}
