import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/articles_controller.dart';

class Articlespage extends StatelessWidget {
  final ArticlesController controller = Get.find<ArticlesController>();

  Articlespage({super.key});

  @override
  Widget build(BuildContext context) {
     controller.loadArticles();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,title:Text("Health Articles",style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold) ),centerTitle: true,),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        if (controller.errorMessage.isNotEmpty) return Center(child: Text(controller.errorMessage.value));

        return ListView(
          padding: const EdgeInsets.all(12),
          children: controller.articles.map((article) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article['cover_image'] != null && article['cover_image'].isNotEmpty)
                   Image.network(article['cover_image'], fit: BoxFit.fill),
                  const SizedBox(height: 8),
                  Text(article['title'] ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(article['publish_date'] ?? '', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(article['content'] ?? ''),
                ],
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
