import 'package:equatable/equatable.dart';

abstract class INetworkClient {
  Future<String> get({required NetworkParams paramas});
}

class NetworkParams extends Equatable {
  final String? endPoint;
  final String? contentType;
  final Map<String, dynamic>? headers;

  const NetworkParams({
    required this.endPoint,
    this.headers,
    this.contentType,
  });

  @override
  List<Object?> get props => [endPoint, contentType, headers];
}
