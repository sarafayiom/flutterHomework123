import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/View/ExerciseDetailPage.dart';
import '../controllers/workout_day_controller.dart';

class musclesPage extends StatefulWidget {
  final String muscleId;
  final String muscleName;
  const musclesPage({
    super.key,
    required this.muscleId,
    required this.muscleName,
  });

  @override
  _musclesPageState createState() => _musclesPageState();
}

class _musclesPageState extends State<musclesPage> {
  final WorkoutDayController controller = Get.find<WorkoutDayController>();

  @override
  void initState() {
    super.initState();
  
    final muscleIdInt = int.tryParse(widget.muscleId) ?? 0;
    if (muscleIdInt != 0) {
      controller.fetchMuscleExercises(muscleIdInt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/image/images.jfif',
                fit: BoxFit.cover,
              ),
              Container(color: Colors.black.withOpacity(0.2)),
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ],
          ),
         
        ),
      ),
      body: Obx(() {
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              'Error: ${controller.errorMessage.value}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final workout = controller.workoutDay.value;

        if (workout == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final exercises = workout.exercises;

        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   // "DAY ${workout.dayNumber}",
                  //   "",
                  //   style: const TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 28,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InfoBox(
                          title:
                              "${workout.totalDurationMinutes.toStringAsFixed(1)} mins",
                          subtitle: "Duration",
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InfoBox(
                          title: "${workout.totalExercises}",
                          subtitle: "Exercises",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final ex = exercises[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      onTap: () {
                        final box = GetStorage();
                        box.write('idexercise', ex.dayExerciseId);
                        Get.to(() => const ExerciseDetailPage());
                      },
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: ex.image,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        ex.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 14),
                      ),
                      subtitle: Text(
                        "x${ex.repetitions}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color.fromARGB(255, 191, 179, 212),
            //       minimumSize: const Size(double.infinity, 50),
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(30)),
            //     ),
            //     onPressed: () async {
            //       final box = GetStorage();
            //       final started = box.read('challenge_started') ?? false;

            //       if (!started) {
            //         try {
            //           await controller.startchallenge();
            //           box.write('challenge_started', true);
            //         } catch (e) {
            //           print('Start challenge failed: $e');
            //           return;
            //         }
            //       }
            //     },
            //     child: const Text("Start",
            //         style: TextStyle(fontSize: 18, color: Colors.white)),
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const InfoBox({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
