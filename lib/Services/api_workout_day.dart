import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Models/workout_day_model.dart';

class ApiWorkoutDay {
  
  final Dio _dio = Dio();
  final box = GetStorage();
  Future<bool> startchallenge() async {
    final token = box.read('access_token');
    final idchallenge = box.read('idchallenge');
    print('idchallenge: $idchallenge');
    try {
      final response = await _dio.post(
        'http://91.144.22.63:4567/boss/start-challenge/$idchallenge/',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Success');
        return true;
      } else {
        print('Failed with status: ${response.statusCode}');

        return false;
      }
    } catch (e) {
      print('Error: $e');

      return false;
    }
  }

 Future<WorkOutDayModel> getdaydetails({required int id}) async {
    final token = box.read("access_token");
    final idchallenge = box.read('idchallenge');
    try {
      final response = await _dio.get(
        'http://91.144.22.63:4567/boss/challenges/$idchallenge/day/$id/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        WorkOutDayModel dayexercise = WorkOutDayModel.fromMap(response.data);
        final idexercise =
            dayexercise.exercises.map((e) => e.dayExerciseId).toList();
        box.write('idexercise', idexercise);
        print(response.data);
        return dayexercise;
      } else {
        throw Exception("Failed to load workout day data");
      }
    } catch (e) {
      throw Exception("Error fetching workout day: $e");
    }
  }

  
  Future<WorkOutDayModel> getmuscledetails({required int id}) async {
     final token = box.read("access_token");
    try {
      final response = await _dio.get(
        'http://91.144.22.63:4567/boss/muscle/$id/exercises/',
         options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
    

      if (response.statusCode == 200) {
        WorkOutDayModel muscleExercise = WorkOutDayModel.fromMap(response.data);
        return muscleExercise;
      } else {
        throw Exception("Failed to load muscle exercises");
      }
    } catch (e) {
      throw Exception("Error fetching muscle exercises: $e");
    }
  }
}
