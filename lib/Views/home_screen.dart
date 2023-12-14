import 'package:arcticle_viewer/Views/fav_article.dart';
import 'package:arcticle_viewer/Views/home_screen_arrtticle.dart';
import 'package:arcticle_viewer/Views/profile_screen.dart';
import 'package:arcticle_viewer/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pagecontroller extends GetxController {
  int currentPageIndex = 0;
  late PageController _pagecontroller;
  @override
  void onInit() {
    super.onInit();
    _pagecontroller = PageController();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Pagecontroller controller = Get.put(Pagecontroller());
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: controller._pagecontroller,
            onPageChanged: (index) {
              controller.currentPageIndex = index;
            },
            children: [
             HomeScreenArticle(),
             FavoriteScreen(),
              ProfileScreen(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
            child: GNav(
                // navigation bar padding
                gap: 10,
                haptic: true,
                onTabChange: (index) {
                  controller._pagecontroller.jumpToPage(index);
                },
                padding: EdgeInsets.all(16),
                backgroundColor: Colors.white,
                tabBackgroundColor: Colors.amberAccent,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Favorites',
                  ),
                  GButton(
                    icon: Icons.person_2,
                    text: 'Profile',
                  )
                ]),
          ),
        ),
      ),
    );
  }
}


