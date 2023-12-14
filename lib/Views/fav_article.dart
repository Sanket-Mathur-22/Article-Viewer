import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/article_model.dart';
import 'home_screen_arrtticle.dart';
class FavoriteScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Favorite Articles"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => controller.favoriteArticles.isEmpty
                ? Center(child: Text('No favorite articles yet.'))
                : ListView.builder(
                    itemCount: controller.favoriteArticles.length,
                    itemBuilder: (context, index) {
                      final Article article = controller.favoriteArticles[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                controller.imgurl,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8),
                              Text(
                                article.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(article.content),
                              SizedBox(height: 8),
                              Divider(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}