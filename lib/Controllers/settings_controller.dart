import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/View/edit_profile.dart';
import 'package:homeworkout_flutter/View/signup..dart';

class SettingsController extends GetxController {
  final box = GetStorage();
  var isDarkMode = false.obs;
  var isMusicPlaying = false.obs;
  final player = AudioPlayer();

  void editProfile() {
   Get.off(() => EditProfile());
  }
  void toggleMusic(bool value) async {
  isMusicPlaying.value = value;
  if (value) {
    await player.setReleaseMode(ReleaseMode.loop);
    await player.play(AssetSource('audio/sport_music.mp3'));
  } else {
    await player.pause();
  }
}
void toggleTheme() {
   
  }
  void logout() {
    box.remove('access_token'); 
    box.remove('refresh_token'); 
    Get.offAll(() => SignUp()); 
  }
}