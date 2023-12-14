import 'package:arcticle_viewer/Views/home_screen.dart';
import 'package:arcticle_viewer/Views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_text_filed.dart';

class SignupController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mobController = TextEditingController();

  Future<void> signUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setString('name', nameController.text);
    await prefs.setString('dateofbirth', dobController.text);
    await prefs.setString('mobilenumber', mobController.text);

    Get.to(LoginScreen());
  }
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());
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
                  height: 10,
                ),
                Text("SIGN UP",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTextField(
                          title: "Full name",
                          hint: "Enter Full name",
                          controller: controller.nameController,
                          icon: Icon(Icons.person)),
                      SizedBox(
                        height: 10,
                      ),
                      customTextField(
                          title: "Username",
                          hint: "Enter username",
                          controller: controller.usernameController,
                          icon: Icon(Icons.person_2)),
                      SizedBox(
                        height: 10,
                      ),
                      customTextField(
                          title: "Password",
                          hint: "Enter password",
                          TextInputType: TextInputType.visiblePassword,
                          controller: controller.passwordController,
                          icon: Icon(Icons.password)),
                      SizedBox(
                        height: 10,
                      ),
                      customTextField(
                          title: "Date of Birth",
                          hint: "Enter DOB(DD/MM/YY)",
                          controller: controller.dobController,
                          icon: Icon(Icons.calendar_month)),
                      SizedBox(
                        height: 10,
                      ),
                      customTextField(
                          title: "Mobile No.",
                          TextInputType: TextInputType.phone,
                          controller: controller.mobController,
                          hint: "Enter your mobile no.",
                          icon: Icon(Icons.mobile_friendly))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.signUp();
                    },
                    child: Text(
                      "Sign up",
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
                      Get.to(LoginScreen());
                    },
                    child: Text("Already have an Account. Log in here !"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
