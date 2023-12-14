import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/article_model.dart';



class HomeController extends GetxController {
  RxList<Article> articles = <Article>[].obs;
  RxList<Article> favoriteArticles = <Article>[].obs;
  RxBool isLoading = true.obs;
  String imgurl = '';

  @override
  void onInit() {
    super.onInit();
    fetchRandomArticles();
    fetchImageUrl();
  }

  Future<void> fetchRandomArticles() async {
    try {
      isLoading(true);

      final response = await http.get(Uri.parse(
          'https://en.wikipedia.org/w/api.php?format=json&action=query&generator=random'
          '&grnnamespace=0&prop=revisions%7Cimages&rvprop=content&grnlimit=5'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> pages = data['query']['pages'];

        List<Article> fetchedArticles = [];

        pages.forEach((key, value) async {
          final content = value['revisions'][0]['*'].toString();
          //final imageUrl = await fetchImageUrl(value['title']);
          fetchedArticles.add(Article(
            title: value['title'],
            content: content,
            //imageUrl: imageUrl,
          ));
        });

        articles.assignAll(fetchedArticles);
      } else {
        print('Failed to load articles. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error loading articles: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<String> fetchImageUrl() async {
  try {
    final response = await http.get(Uri.parse(
        'https://commons.wikimedia.org/w/api.php?action=query&prop=imageinfo&iiprop=timestamp%7Cuser%7Curl&generator=categorymembers&gcmtype=file&gcmtitle=Category:Featured_pictures_on_Wikimedia_Commons&format=json&utf8'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('query') && data['query'] != null) {
        final Map<String, dynamic> pages = data['query']['pages'];

        if (pages.isNotEmpty) {
          final List<dynamic> imageInfo = pages.values.first['imageinfo'];

          if (imageInfo != null && imageInfo.isNotEmpty) {
            imgurl = imageInfo.first['url'].toString();
          }
        }
      } else {
        print('Malformed response: No "query" or "pages" found.');
      }
    } else {
      print('Failed to load image. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error loading image: $error');
  }

  return ''; 
}

  void markAsFavorite(Article article) {
    print('Marked as favorite: ${article.title}');
    favoriteArticles.add(article);
  }
}

class HomeScreenArticle extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Articles"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(
              () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: controller.articles.length,
                      itemBuilder: (context, index) {
                        final Article article = controller.articles[index];
                        return Card(
                          //color: Colors.amberAccent,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.favorite_border),
                                      onPressed: () {
                                        controller.markAsFavorite(article);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}