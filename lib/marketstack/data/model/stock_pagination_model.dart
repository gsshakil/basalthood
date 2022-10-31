import 'package:basalt_task/marketstack/data/model/pagination_model.dart';
import 'package:basalt_task/marketstack/data/model/stock_model.dart';
import 'package:equatable/equatable.dart';

class StockPaginationModel extends Equatable {
  final Pagination pagination;
  final List<StockModel> data;

  const StockPaginationModel({
    required this.pagination,
    required this.data,
  });

  StockPaginationModel copyWith({
    Pagination? pagination,
    List<StockModel>? data,
  }) {
    return StockPaginationModel(
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
    );
  }

  factory StockPaginationModel.init() => StockPaginationModel(
        pagination: Pagination.init(),
        data: const [],
      );

  factory StockPaginationModel.fromJson(Map<String, dynamic> json) =>
      StockPaginationModel(
        pagination: Pagination.fromJson(json["pagination"]),
        data: List<StockModel>.from(
            json["data"].map((x) => StockModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [
        pagination,
        data,
      ];
}
