import 'package:basalt_task/marketstack/data/model/pagination_model.dart';
import 'package:basalt_task/marketstack/data/model/ticker_model.dart';
import 'package:equatable/equatable.dart';

class TickerPaginationModel extends Equatable {
  final Pagination pagination;
  final List<TickerModel> data;

  const TickerPaginationModel({
    required this.pagination,
    required this.data,
  });

  TickerPaginationModel copyWith({
    Pagination? pagination,
    List<TickerModel>? data,
  }) {
    return TickerPaginationModel(
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
    );
  }

  factory TickerPaginationModel.init() => TickerPaginationModel(
        pagination: Pagination.init(),
        data: const [],
      );

  factory TickerPaginationModel.fromJson(Map<String, dynamic> json) =>
      TickerPaginationModel(
        pagination: Pagination.fromJson(json["pagination"]),
        data: List<TickerModel>.from(
            json["data"].map((x) => TickerModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [
        pagination,
        data,
      ];
}
