import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Challenge2Page extends StatefulWidget {
  const Challenge2Page({super.key});

  @override
  State<Challenge2Page> createState() => _Challenge1PageState();
}

class _Challenge1PageState extends State<Challenge2Page> {
  int availableDays = 1;

  @override
  void initState() {
    super.initState();
    _checkAvailableDays();
  }

  Future<void> _checkAvailableDays() async {
    final prefs = await SharedPreferences.getInstance();
    final firstUnlock = prefs.getInt('first_day_unlock_time');
    final now = DateTime.now().millisecondsSinceEpoch;

    if (firstUnlock == null) {
      await prefs.setInt('first_day_unlock_time', now);
    } else {
      final elapsed = now - firstUnlock;
      final daysPassed = (elapsed / (1000 * 60 * 60 * 24)).floor();
      setState(() {
        availableDays = 1 + daysPassed.clamp(0, 7);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Challenge"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
          
            SliverToBoxAdapter(
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/photo_2025-05-29_19-20-19.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
            //     alignment: Alignment.center,
            //     child: Container(
            //       color: Colors.black.withOpacity(0.4),
            //       child: const Padding(
            //         padding: EdgeInsets.all(8.0),
            //         child: Text(
            //           "CHALLENGE ACCORDING TO YOUR GOALS",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 24,
            //             fontWeight: FontWeight.bold,
            //             shadows: [Shadow(blurRadius: 6, color: Colors.black)],
            //           ),
            //         ),
            //       ),
            //     ),
             ),
             ),

          
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LinearProgressIndicator(
                  value: availableDays / 28,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.deepPurple,
                ),
              ),
            ),

          
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final weekIndex = index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Week ${weekIndex + 1}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 8, 
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8, 
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            if (index < 7) {
                              final globalDayIndex = weekIndex * 7 + index;
                              final isUnlocked = globalDayIndex < availableDays;
                              return CircleAvatar(
                                backgroundColor: isUnlocked ?  const Color.fromARGB(255, 191, 179, 212) : Colors.grey.shade300,
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: isUnlocked ? Colors.white : Colors.black26,
                                  ),
                                ),
                              );
                            } else {
                             
                              final isWeekCompleted = (weekIndex + 1) * 7 <= availableDays;
                              return CircleAvatar(
                                backgroundColor: isWeekCompleted ? Colors.yellow : Colors.grey.shade300,
                                child: Icon(
                                  Icons.emoji_events,
                                  color: isWeekCompleted ? Colors.black : Colors.black26,
                                  size: 20,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
                childCount: 4,
              ),
            ),

        
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color.fromARGB(255, 191, 179, 212),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                  
                  },
                  child: const Center(
                    child: Text(
                      "GO",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
