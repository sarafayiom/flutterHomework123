import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/View/Exercises_by_type.dart';
import 'package:homeworkout_flutter/controllers/workout_day_controller.dart';

class MusclesPage extends StatefulWidget {
  final String muscleId;
  final String muscleName;
  const MusclesPage({
    super.key,
    required this.muscleId,
    required this.muscleName,
  });

  @override
  _musclesPageState createState() => _musclesPageState();
}

class _musclesPageState extends State<MusclesPage> {
  final WorkoutDayController controller1 = Get.find<WorkoutDayController>();

  @override
  void initState() {
    super.initState();

    final muscleIdInt = int.tryParse(widget.muscleId) ?? 0;
    if (muscleIdInt != 0) {
      controller1.fetchMuscleExercises(muscleIdInt);
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
                'assets/image/240_F_383441501_CLDIkg5Xp2gznsRBw8tYlia2XzfNF4BI.jpg',
                fit: BoxFit.cover,
              ),
              Container(color: Colors.black.withOpacity(0.1)),
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (controller1.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              'Error: ${controller1.errorMessage.value}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final muscleExercise = controller1.muscle.value;

        if (muscleExercise == null) {
          return const Center(child: CircularProgressIndicator(color: Colors.grey,));
        }

        final exercises = muscleExercise.exercises;

        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InfoBox(
                          title:
                              "${muscleExercise.totalduration.toStringAsFixed(1)} mins",
                          subtitle: "Duration",
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InfoBox(
                          title: "${muscleExercise.totalExercises}",
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
                    color: const Color.fromARGB(255, 247, 240, 237),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      onTap: () {
                        final box = GetStorage();
                        box.write('idexercise', ex.id);
                        print("'idexercise' : ${ex.id}");
                        Get.to(() => ExercisebyTypePage(exerciseId: ex.id));
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
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 14),
                      ),
                      subtitle: Text(
                        "x${ex.durationSeconds}",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),
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
        color: const Color.fromARGB(255, 245, 228, 217),
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
