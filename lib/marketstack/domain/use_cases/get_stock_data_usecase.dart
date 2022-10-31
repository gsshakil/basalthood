import 'package:basalt_task/core/error/failure.dart';
import 'package:basalt_task/marketstack/data/model/stock_pagination_model.dart';
import 'package:basalt_task/marketstack/domain/repositories/marketstack_repository.dart';
import 'package:dartz/dartz.dart';

class GetStockDataUseCase {
  MarketStackRepository marketStackRepository;

  GetStockDataUseCase({required this.marketStackRepository});

  Future<Either<Failure, StockPaginationModel>> call(
      {required int limit, required int offset}) async {
    return await marketStackRepository.getStockData(
        limit: limit, offset: offset);
  }
}
