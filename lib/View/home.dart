// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:homeworkout_flutter/Controllers/home_controller.dart';
// import 'package:homeworkout_flutter/Models/user_challenge_model.dart';
// import 'package:homeworkout_flutter/View/Articlespage.dart';
// import 'package:homeworkout_flutter/View/Challenge1Page.dart';
// import 'package:homeworkout_flutter/View/Challenge2Page.dart';
// import 'package:homeworkout_flutter/View/ReportPage.dart';
// import 'package:homeworkout_flutter/View/SettingsPage.dart';
// import 'package:homeworkout_flutter/constants/app_colors.dart';
// import 'package:homeworkout_flutter/constants/app_styles.dart';
// import 'package:homeworkout_flutter/widgets/challenge_card.dart';

// class TrainingPage extends StatefulWidget {
//    TrainingPage({Key? key}) : super(key: key);

//   @override
//   State<TrainingPage> createState() => _TrainingPageState();
// }

// class _TrainingPageState extends State<TrainingPage> {
//   int selectedIndex = 0;

//   final List<Widget> _pages = [
//     TrainingContent(),
//     Articlespage(),
//     Reportpage(),
//     Settingspage(),
//   ];

//   void onNavTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'HOME WORKOUT',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: _pages[selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedIndex,
//         onTap: onNavTapped,
//         backgroundColor: AppColors.background,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: AppColors.primary,
//         unselectedItemColor: AppColors.secondary,
//         showUnselectedLabels: true,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.fitness_center_outlined),
//             label: 'Training',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: 'Health Articles',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart_outlined),
//             label: 'Report',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings_outlined),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TrainingContent extends StatefulWidget {
//   TrainingContent({Key? key}) : super(key: key);

//   @override
//   State<TrainingContent> createState() => _TrainingContentState();
// }

// class _TrainingContentState extends State<TrainingContent> {
//   final homeController = Get.find<HomeController>();

//   String selectedBodyPart = "Arms";

//  final List<Map<String, String>> musclegroups = [
//   {"id": "4", "name": "chest"},
//   {"id": "3", "name": "back"},
//   {"id": "1", "name": "arms"},
//   {"id": "2", "name": "legs"},
//   {"id": "5", "name": "glutes"},
//   {"id": "6", "name": "full_body"},
// ];
// late final List<String> bodyParts;

//   String selectedBodyPart = "arms"; 


//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
           
//             Text("7x4 Challenge", style: AppStyles.headerMedium),
//             const SizedBox(height: 12),
//            SingleChildScrollView(
//   scrollDirection: Axis.horizontal,
//  child: Obx(() {
//   if (homeController.isLoading.value) {
//     return SizedBox(
//       height: 180,
//       width: MediaQuery.of(context).size.width,
//       child: Center(child: CircularProgressIndicator()),
//     );
//   } else if (homeController.userChallenges.value == null ||
//       (homeController.userChallenges.value!.userChallenge == null &&
//           (homeController.userChallenges.value!.publicChallenges == null ||
//               homeController.userChallenges.value!.publicChallenges!.isEmpty))) {
   
//     return SizedBox(
//       height: 180,
//       width: MediaQuery.of(context).size.width,
//       child: Center(child: Text('No Challenge Found')),
//     );
//   } else {
//     UserChallengeModel userChallenges = homeController.userChallenges.value!;
//     List<Widget> challengeCards = [];
//     if (userChallenges.userChallenge != null) {
//       challengeCards.add(
//         ChallengeCard(
//           title: userChallenges.userChallenge!.name,
//           description: "4 weeks to achieve your goal!",
//           imagePath: 'assets/image/Personalized workouts-amico.png',
//           onTap: () {
//             Get.to(() => Challenge1Page());
//           },
//           showStartButton: true,
//         ),
//       );
//     }

    
//     if (userChallenges.publicChallenges != null &&
//         userChallenges.publicChallenges!.isNotEmpty) {
//       challengeCards.add(
//         ChallengeCard(
//           title: userChallenges.publicChallenges!.first.name ?? 'Unnamed Public Challenge',
//           description: "",
//           imagePath: 'assets/image/Training at home-amico.png',
//           onTap: () {
//             Get.to(() => const Challenge2Page());
//           },
//           showStartButton: true,
//         ),
//       );
//     }

//     return Row(
//       children: challengeCards,
//     );
//   }
// }),

// ),

//             const SizedBox(height: 30),

           
//             Text("Body Focus", style: AppStyles.headerMedium),
//             const SizedBox(height: 20),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: bodyParts.map((part) {
//                   return _buildBodyTab(part, selectedBodyPart == part, () {
//                     setState(() {
//                       selectedBodyPart = part;
//                     });
//                   });
//                 }).toList(),
//               ),
//             ),
//             const SizedBox(height: 30),
            
//             Text("Stretch & Warm Up", style: AppStyles.headerMedium),
//             const SizedBox(height: 30),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: const [
//                   ChallengeCard(
//                     title: "Warm Up Exercises",
//                     description: "",
//                     imagePath: 'assets/image/Physical education-pana.png',
//                   ),
//                   SizedBox(width: 10),
//                   ChallengeCard(
//                     title: "Stretch Exercises",
//                     description: "",
//                     imagePath: 'assets/image/stretch.jpg',
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBodyTab(String label, bool isSelected, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.only(right: 8),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             color: isSelected ? AppColors.primary : Colors.grey.shade200,
//             borderRadius: BorderRadius.circular(18),
//           ),
//           child: Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? AppColors.background : AppColors.textPrimary,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/home_controller.dart';
import 'package:homeworkout_flutter/Controllers/notification_controller.dart';
import 'package:homeworkout_flutter/Controllers/report_controller.dart';
import 'package:homeworkout_flutter/Models/user_challenge_model.dart';
import 'package:homeworkout_flutter/View/Articlespage.dart';
import 'package:homeworkout_flutter/View/Challenge1Page.dart';
import 'package:homeworkout_flutter/View/Challenge2Page.dart';
import 'package:homeworkout_flutter/View/ReportPage.dart';
import 'package:homeworkout_flutter/View/SettingsPage.dart';
import 'package:homeworkout_flutter/View/musclesexercise.dart';
import 'package:homeworkout_flutter/constants/app_colors.dart';
import 'package:homeworkout_flutter/constants/app_styles.dart';
import 'package:homeworkout_flutter/widgets/challenge_card.dart';

class TrainingPage extends StatefulWidget {
   TrainingPage({super.key});
final ReportController controller = Get.find<ReportController>();
  @override
  State<TrainingPage> createState() => _TrainingPageState();
}
class _TrainingPageState extends State<TrainingPage> {
  late NotificationController controller1;

  int selectedIndex = 0;

  final List<Widget> _pages = [
    TrainingContent(),
    Articlespage(),
    Reportpage(),
    Settingspage(),
  ];

  void onNavTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    controller1 = Get.find<NotificationController>();
    controller1.requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'HOME WORKOUT',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onNavTapped,
        backgroundColor: AppColors.background,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondary,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Health Articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class TrainingContent extends StatefulWidget {
  const TrainingContent({super.key});

  @override
  State<TrainingContent> createState() => _TrainingContentState();
}

class _TrainingContentState extends State<TrainingContent> {
  final homeController = Get.find<HomeController>();

  final List<Map<String, String>> musclegroups = [
    {"id": "1", "name": "arms"},
    {"id": "2", "name": "legs"},
    {"id": "3", "name": "back"},
    {"id": "4", "name": "chest"},
    {"id": "5", "name": "glutes"},
    {"id": "6", "name": "full_body"},
  ];

  late final List<String> bodyParts;

  String selectedBodyPart = "arms";

  @override
  void initState() {
    super.initState();
    bodyParts = musclegroups.map((e) => e['name']!).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text("7x4 Challenge", style: AppStyles.headerMedium),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                if (homeController.isLoading.value) {
                  return SizedBox(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (homeController.userChallenges.value == null ||
                    (homeController.userChallenges.value!.userChallenge == null &&
                        (homeController.userChallenges.value!.publicChallenges ==
                                null ||
                            homeController.userChallenges.value!
                                .publicChallenges!.isEmpty))) {
                  return SizedBox(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text('No Challenge Found')),
                  );
                } else {
                  UserChallengeModel userChallenges =
                      homeController.userChallenges.value!;
                  List<Widget> challengeCards = [];
                  if (userChallenges.userChallenge != null) {
                    challengeCards.add(
                      ChallengeCard(
                        title: userChallenges.userChallenge!.name,
                        description: "4 weeks to achieve your goal!",
                        imagePath: 'assets/image/Personalized workouts-amico.png',
                        onTap: () {
                          Get.to(() => Challenge1Page());
                        },
                        showStartButton: true,
                      ),
                    );
                  }

                  if (userChallenges.publicChallenges != null &&
                      userChallenges.publicChallenges!.isNotEmpty) {
                    challengeCards.add(
                      ChallengeCard(
                        title: userChallenges.publicChallenges!.first.name ??
                            'Unnamed Public Challenge',
                        description: "",
                        imagePath: 'assets/image/Training at home-amico.png',
                        onTap: () {
                          Get.to(() => const Challenge2Page());
                        },
                        showStartButton: true,
                      ),
                    );
                  }

                  return Row(
                    children: challengeCards,
                  );
                }
              }),
            ),
            const SizedBox(height: 30),
            Text("Body Focus", style: AppStyles.headerMedium),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: bodyParts.map((part) {
                  final isSelected = selectedBodyPart == part;
                  return _buildBodyTab(part, isSelected);
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            Text("Stretch & Warm Up", style: AppStyles.headerMedium),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  ChallengeCard(
                    title: "Warm Up Exercises",
                    description: "",
                    imagePath: 'assets/image/Physical education-pana.png',
                  ),
                  SizedBox(width: 10),
                  ChallengeCard(
                    title: "Stretch Exercises",
                    description: "",
                    imagePath: 'assets/image/stretch.jpg',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyTab(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        final muscle = musclegroups.firstWhere(
          (element) => element['name']!.toLowerCase() == label.toLowerCase(),
          orElse: () => {"id": "0", "name": "unknown"},
        );
        final muscleId = muscle['id']!;
        Get.to(() => musclesPage(muscleId: muscleId, muscleName: label));
        setState(() {
          selectedBodyPart = label;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.background : AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}




