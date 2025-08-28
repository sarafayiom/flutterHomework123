import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'api_refresh_token.dart';

class ApiArticles extends GetConnect {
  final box = GetStorage();
  final apiRefreshToken = Get.find<ApiRefreshToken>();

  @override
  void onInit() {
    httpClient.baseUrl = "http://workout.ofc.com.sy:4567/boss"; 
    super.onInit();
  }

  Future<Map<String, String>> getHeaders() async {
    final token = box.read('access_token');
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> fetchArticles() async {
    var headers = await getHeaders();

    Response response = await get(
      '/articles/',
      headers: headers,
    ).timeout(Duration(seconds: 10));

    if (response.statusCode == 401) {
      bool refreshed = await apiRefreshToken.refreshToken();
      if (refreshed) {
        headers = await getHeaders();
        response = await get(
          '/articles/',
          headers: headers,
        ).timeout(Duration(seconds: 10));
      }
    }

    return response;
  }
}
