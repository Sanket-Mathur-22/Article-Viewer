import 'package:arcticle_viewer/Views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_card.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _getUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading user details'));
        } else {
          Map<String, String> userDetails =
              snapshot.data ?? {}; // Use default value if null
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.amberAccent,
                          backgroundImage: AssetImage('assets/profile.png'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${userDetails['username']}',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 350,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Personal details",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                customcard(
                                    title: "Full Name: ${userDetails['name']}"),
                                SizedBox(
                                  height: 20,
                                ),
                                customcard(
                                    title:
                                        "Mob.No. : ${userDetails['mobilenumber']}"),
                                SizedBox(
                                  height: 20,
                                ),
                                customcard(
                                    title:
                                        "DOB : ${userDetails['dateofbirth']}"),
                                SizedBox(
                                  height: 60,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _logout();
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.only(left: 18),
                                    elevation: 8.0,
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: 320,
                                      height: 55,
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        contentPadding:
                                            EdgeInsets.only(left: 98),
                                        leading: Icon(Icons.logout),
                                        tileColor: Colors.white,
                                        title: Text(
                                          "Log out",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

Future<Map<String, String>> _getUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username') ?? '';
  String password = prefs.getString('password') ?? '';
  String name = prefs.getString('name') ?? '';
  String mobilenumber = prefs.getString('mobilenumber') ?? '';
  String dateofbirth = prefs.getString('dateofbirth') ?? '';

  return {
    'username': username,
    'name': name,
    'mobilenumber': mobilenumber,
    'dateofbirth': dateofbirth
  };
}

Future<void> _logout() async {
   Get.offAll(() => LoginScreen()); 
}
