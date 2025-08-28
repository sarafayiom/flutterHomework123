import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class HomeApiService {
  final Dio _dio = Dio();
   final box = GetStorage(); 
  Future<bool> checkDayAvailability(int challengeId, int day) async {
     final token = box.read("access_token");
    try {
      final response = await _dio.get(
        'http://91.144.22.63:4567/boss/check-day-availability/$challengeId/$day',
        options: Options(
          headers: {
             'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    final isAvailable = response.data['is_available'] == true;
      return isAvailable;
    } catch (e) {
      print("Error checking day availability: $e");
       

      return false;
    
    }
  }
}
