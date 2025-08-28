import 'package:get/get.dart';
import 'package:homeworkout_flutter/Models/workout_day_model.dart';
import 'package:homeworkout_flutter/Services/api_workout_day.dart';

class WorkoutDayController extends GetxController {
  final ApiWorkoutDay _apiWorkoutDay = ApiWorkoutDay();
  var workoutDay = Rxn<WorkOutDayModel>();
  RxString errorMessage = ''.obs;


  Future<void> startchallenge() async {
    try {
     await _apiWorkoutDay.startchallenge();
    } catch (e) {
      print('Error: $e');
    } finally {
    }
  }

  Future<void> fetchWorkoutDay(int dayId) async {
    try {
      final result = await _apiWorkoutDay.getdaydetails(id: dayId);
      workoutDay.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
      print('WorkoutDayController Error: $e');
    }
  }

  Future<void> fetchMuscleExercises(int muscleId) async {
    try {
      final result = await _apiWorkoutDay.getmuscledetails(id: muscleId);
      workoutDay.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
      print('WorkoutDayController Error: $e');
    }
  }
}
