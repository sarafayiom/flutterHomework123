import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Bindings/binding.dart';
import 'package:homeworkout_flutter/Controllers/notification_controller.dart';
import 'package:homeworkout_flutter/View/Challenge1Page.dart';
import 'package:homeworkout_flutter/View/Challenge2Page.dart';
import 'package:homeworkout_flutter/View/ExerciseDetailPage.dart';
import 'package:homeworkout_flutter/View/WorkOutDayPage.dart';
import 'package:homeworkout_flutter/View/create_challenge.dart';
import 'package:homeworkout_flutter/View/home.dart';
import 'package:homeworkout_flutter/View/login.dart';
import 'package:homeworkout_flutter/View/signup..dart';
import 'package:homeworkout_flutter/View/signup_step3.dart';
import 'package:homeworkout_flutter/View/signup_step4.dart';
import 'package:homeworkout_flutter/View/startupscreen.dart';
import 'package:homeworkout_flutter/View/temporarypage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  String? token = await FirebaseMessaging.instance.getToken();
  GetStorage store = GetStorage();
  if (token != null) {
    store.write("fcm_token", token);
    print("FCM Token saved: $token");
  } else {
    print("FCM Token is null!");
  }
  print("FCM Token: $token");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _Myapp();
}

class _Myapp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      initialBinding: Binding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => StartupScreen()),
        GetPage(name: '/login', page: () => LogIn()),
        GetPage(name: '/signup_step1', page: () => SignUp()),
        GetPage(name: '/signup_step3', page: () => SignupStep3()),
        GetPage(name: '/signup_step4', page: () => SignupStep4()),
        GetPage(name: '/CreateChallenge', page: () => CreateChallenge()),
        GetPage(name: '/TrainingPage', page: () => TrainingPage()),
        GetPage(name: '/Challenge1Page', page: () => Challenge1Page()),
        GetPage(name: '/Challenge2Page', page: () => Challenge2Page()),
        GetPage(
          name: '/WorkoutDayPage',
          page: () {
            final day = int.tryParse(Get.parameters['day'] ?? '1') ?? 1;
            return WorkoutDayPage(day: day);
          },
        ),
        GetPage(name: '/exercise_page', page: () => ExerciseDetailPage()),
        GetPage(
          name: '/WorkoutTimerScreen',
          page: () {
            final int exerciseId = Get.arguments;
            return WorkoutTimerScreen(exerciseId: exerciseId);
          },
        ),
      ],
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
