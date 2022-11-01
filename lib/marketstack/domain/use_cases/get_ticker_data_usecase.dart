import 'package:basalt_task/core/error/failure.dart';
import 'package:basalt_task/marketstack/data/model/ticker_pagination_model.dart';
import 'package:basalt_task/marketstack/domain/repositories/marketstack_repository.dart';
import 'package:dartz/dartz.dart';

class GetTickerDataUseCase {
  MarketStackRepository marketStackRepository;

  GetTickerDataUseCase({required this.marketStackRepository});

  Future<Either<Failure, TickerPaginationModel>> call() async {
    return await marketStackRepository.getTickerData();
  }
}
