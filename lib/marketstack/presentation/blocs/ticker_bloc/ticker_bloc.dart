import 'package:basalt_task/core/error/failure.dart';
import 'package:basalt_task/marketstack/data/model/ticker_model.dart';
import 'package:basalt_task/marketstack/data/model/ticker_pagination_model.dart';
import 'package:basalt_task/marketstack/domain/use_cases/get_ticker_data_usecase.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'ticker_event.dart';
part 'ticker_state.dart';

class TickerBloc extends Bloc<TickerEvent, TickerState> {
  final GetTickerDataUseCase getTickerDataUseCase;
  TickerBloc({required this.getTickerDataUseCase}) : super(TickerInitial()) {
    on<GetTickerData>((event, emit) async {
      emit(TickerLoading());
      Either<Failure, TickerPaginationModel> result =
          await getTickerDataUseCase();
      result.fold((l) => emit(TickerError(error: l.message)), (r) {
        emit(TickerSuccess(tickerData: r.data));
      });
    });
  }
}
