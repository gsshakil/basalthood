import 'dart:convert';
import 'package:basalt_task/core/error/exceptions.dart';
import 'package:dio/dio.dart';
import 'i_network_client.dart';

class DioNetworkClient implements INetworkClient {
  final Dio dio;

  DioNetworkClient({required this.dio});

  @override
  Future<String> get({required NetworkParams paramas}) async {
    Response response;
    try {
      response = await dio.get(
        paramas.endPoint!,
        options: Options(
          headers: paramas.headers,
          contentType: paramas.contentType,
        ),
      );

      return jsonEncode(response.data);
    } on DioError catch (e) {
      throw ServerException(
        errorMessage: e.message,
        errorData: e.response != null
            ? e.response!.data.toString()
            : e.requestOptions.data,
      );
    }
  }
}
