import 'package:basalt_task/core/error/failure.dart';
import 'package:basalt_task/marketstack/data/model/stock_model.dart';
import 'package:basalt_task/marketstack/data/model/stock_pagination_model.dart';
import 'package:basalt_task/marketstack/domain/use_cases/get_stock_data_usecase.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final GetStockDataUseCase getStockDataUseCase;

  StockPaginationModel stockPaginationModel = StockPaginationModel.init();

  List<StockModel> _stockData = [];
  List<StockModel> get getStockData => _stockData;
  int _offset = 0;
  int limit = 20;

  StockBloc({required this.getStockDataUseCase}) : super(StockInitial()) {
    on<GetStockData>((event, emit) async {
      _offset = 0;
      _stockData = [];
      emit(StockLoading());
      Either<Failure, StockPaginationModel> result =
          await getStockDataUseCase.call(
        limit: limit,
        offset: _offset,
        dateFrom: event.dateFrom,
        dateTo: event.dateTo,
        symbol: event.symbol,
      );
      _offset++;
      result.fold((l) => emit(StockError(error: l.message)), (r) {
        stockPaginationModel = r;
        _stockData.addAll(r.data);
        emit(StockSuccess(stockData: _stockData));
      });
    });

    on<GetMoreStockData>((event, emit) async {
      if (_offset == 0 ||
          _offset <= stockPaginationModel.pagination.total ~/ limit) {
        emit(StockMoreLoading());
        Either<Failure, StockPaginationModel> result =
            await getStockDataUseCase.call(
          limit: limit,
          offset: _offset,
          dateFrom: event.dateFrom,
          dateTo: event.dateTo,
          symbol: event.symbol,
        );
        _offset++;
        result.fold((l) => emit(StockError(error: l.message)), (r) {
          stockPaginationModel = r;
          _stockData.addAll(r.data);
          emit(StockSuccess(stockData: _stockData));
        });
      }
    });
  }
}
