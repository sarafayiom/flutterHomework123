import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/startupscreen_controller.dart';

class StartupScreen extends StatelessWidget {
  final splashController = Get.find<SplashController>();
  StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity, 
          height: double.infinity,  
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/photo_2025-08-28_20-55-22.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
