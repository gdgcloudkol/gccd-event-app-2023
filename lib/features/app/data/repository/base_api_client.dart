abstract class BaseApiClient<T,Client> {
  String baseUrl;

  final Client client;

  BaseApiClient({required this.baseUrl, required this.client});

  void configure();

  Future<T> getData(String endPoint,Map<String,dynamic> dataPayload);

  Future<T> postData(String endPoint,Map<String,dynamic> dataPayload);
}
