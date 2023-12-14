import 'package:arcticle_viewer/Views/home_screen.dart';
import 'package:arcticle_viewer/Views/signup_screen.dart';
import 'package:arcticle_viewer/widgets/custom_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final snackbar =
      SnackBar(content: Text("Login failed. Please check your credentials."));

  Future<void> login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    String? storedPassword = prefs.getString('password');

    if (storedUsername == usernameController.text &&
        storedPassword == passwordController.text) {
      Get.to(HomeScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/logo1.png',
                  height: 70,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("LOGIN",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTextField(
                          title: "Username",
                          controller: controller.usernameController,
                          hint: "Enter username"),
                      SizedBox(
                        height: 10,
                      ),
                      customTextField(
                          title: "Password",
                          controller: controller.passwordController,
                          hint: "Enter password")
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.login(context);
                    },
                    child: Text(
                      "Login here",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(SignupScreen());
                    },
                    child: Text("Dont't have an Account. Signup !"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
