import 'package:get/get.dart';
import 'package:homeworkout_flutter/Services/api_exercise_detail.dart';
import 'package:homeworkout_flutter/models/exercise_model.dart';

class ExercisesController extends GetxController{
  final ApiExerciseDetail _apiExerciseDetail = ApiExerciseDetail();

var exerciseDetail = Rxn<ExerciseDetailModel>();
  RxString errorMessage = ''.obs;

  
   @override
   void onInit() {
    super.onInit();
    fetchExerciseDetail();
    
  }


  Future<void> fetchExerciseDetail() async {
    try {
      errorMessage.value = '';

      final result = await _apiExerciseDetail.getexercisedetail();
     exerciseDetail.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
      print('WorkoutDayController Error: $e');
    } finally {
     
    }
  }
}

