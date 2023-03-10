import 'package:ccd2023/features/app/data/repository/base_api_client.dart';
import 'package:dio/dio.dart';

class DioApiClient extends BaseApiClient<Response, Dio> {
  DioApiClient({required super.baseUrl, required super.client});

  @override
  Future<Response> getData(
      String endPoint, Map<String, dynamic> dataPayload) async {
    try {
      return await client.get(
        baseUrl + endPoint,
        data: dataPayload,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> postData(
      String endPoint, Map<String, dynamic> dataPayload) async {
    try {
      return await client.post(
        baseUrl + endPoint,
        data: dataPayload,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void configure() {
    client.options.baseUrl = baseUrl;
  }
}
