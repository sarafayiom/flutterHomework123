import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/articles_controller.dart';
import 'package:homeworkout_flutter/Controllers/challenge_controller.dart';
import 'package:homeworkout_flutter/Controllers/edit_profile_controller.dart';
import 'package:homeworkout_flutter/Controllers/notification_controller.dart';
import 'package:homeworkout_flutter/Controllers/report_controller.dart';
import 'package:homeworkout_flutter/Services/api_articles.dart';
import 'package:homeworkout_flutter/Services/api_challenge1.dart';
import 'package:homeworkout_flutter/Services/api_user_state_controller.dart';
import 'package:homeworkout_flutter/controllers/exercises_controller.dart';
import 'package:homeworkout_flutter/Controllers/home_controller.dart';
import 'package:homeworkout_flutter/Controllers/login_controller.dart';
import 'package:homeworkout_flutter/Controllers/settings_controller.dart';
import 'package:homeworkout_flutter/Controllers/signup_step1_controller.dart';
import 'package:homeworkout_flutter/Controllers/signup_step2_controller.dart';
import 'package:homeworkout_flutter/Controllers/signup_step3_controller.dart';
import 'package:homeworkout_flutter/Controllers/signup_step4_controller.dart';
import 'package:homeworkout_flutter/Controllers/signup_step5_controller.dart';
import 'package:homeworkout_flutter/Controllers/startupscreen_controller.dart';
import 'package:homeworkout_flutter/controllers/workout_day_controller.dart';
import 'package:homeworkout_flutter/Services/api_basic_info.dart';
import 'package:homeworkout_flutter/Services/api_complete_profile_model.dart';
import 'package:homeworkout_flutter/Services/api_exercise_detail.dart';
import 'package:homeworkout_flutter/Services/api_login.dart';
import 'package:homeworkout_flutter/Services/api_more_details.dart';
import 'package:homeworkout_flutter/Services/api_otp.dart';
import 'package:homeworkout_flutter/Services/api_refresh_token.dart';
import 'package:homeworkout_flutter/Services/api_register.dart';
import 'package:homeworkout_flutter/Services/api_user_challenge.dart';
import 'package:homeworkout_flutter/services/api_workout_day.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    //   final challengeController = Get.put(ChallengeController(), permanent: true);
    //  challengeController.loadAvailableDays();
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    Get.lazyPut(() => Signup2Controller(), fenix: true);
    Get.lazyPut(() => Signup3Controller(), fenix: true);
    Get.lazyPut(() => Signup4Controller(), fenix: true);
    Get.lazyPut(() => Signup5Controller(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => WorkoutDayController(), fenix: true);
    Get.lazyPut(() => ExercisesController(), fenix: true);
    Get.lazyPut(() => ChallengeController(), fenix: true);
    Get.lazyPut<ApiLogin>(() => ApiLogin(), fenix: true);
    Get.lazyPut<ApiRegister>(() => ApiRegister(), fenix: true);
    Get.lazyPut<ApiOtp>(() => ApiOtp(), fenix: true);
    Get.lazyPut<ApiBasicInfo>(() => ApiBasicInfo(), fenix: true);
    Get.lazyPut<ApiMoreDetails>(() => ApiMoreDetails(), fenix: true);
    Get.lazyPut<ApiCompleteProfile>(() => ApiCompleteProfile(), fenix: true);
    Get.lazyPut<ApiRefreshToken>(() => ApiRefreshToken(), fenix: true);
    Get.lazyPut<ApiUserChallenge>(() => ApiUserChallenge(), fenix: true);
    Get.lazyPut<ApiWorkoutDay>(() => ApiWorkoutDay(), fenix: true);
    Get.lazyPut<ApiExerciseDetail>(() => ApiExerciseDetail(), fenix: true);
    Get.lazyPut(() => HomeApiService(), fenix: true);
    Get.lazyPut<ApiUserState>(() => ApiUserState(), fenix: true);
    Get.lazyPut(() => ReportController(), fenix: true);
    Get.lazyPut<ApiArticles>(() => ApiArticles(), fenix: true);
    Get.lazyPut(() => ArticlesController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => EditProfileController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
  }
}
