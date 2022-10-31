import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int limit;
  final int offset;
  final int count;
  final int total;
  const Pagination({
    required this.limit,
    required this.offset,
    required this.count,
    required this.total,
  });

  Pagination copyWith({
    int? limit,
    int? offset,
    int? count,
    int? total,
  }) {
    return Pagination(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      count: count ?? this.count,
      total: total ?? this.total,
    );
  }

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        limit: json["limit"] ?? 0,
        offset: json["offset"] ?? 0,
        count: json["count"] ?? 0,
        total: json["total"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "count": count,
        "total": total,
      };

  factory Pagination.init() => const Pagination(
        limit: 10,
        offset: 0,
        count: 0,
        total: 0,
      );

  @override
  List<Object?> get props => [
        limit,
        offset,
        count,
        total,
      ];
}
