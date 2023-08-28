import 'package:becuser3/themes/my_colors.dart';
import 'package:becuser3/controllers/auth/google_auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:becuser3/screens/auth/signInScreen.dart';
import 'package:get/get.dart';

class Four0Four extends StatelessWidget {
  const Four0Four({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset('assets/images/404.jpg'),
              Card(
                margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'it seems that you didn\'t complete with your profile last time, or you are lost somewhere.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MyClr.apriClr,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Card(
                color: MyClr.priClr100,
                margin: const EdgeInsets.only(top: 8, left: 25, right: 25),
                elevation: 10,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.5, vertical: 4),
                  child: Text(
                    'please go back to login page and complete your profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                child: const Text('Go back to Login page'),
                onPressed: () async {
                  GoogleAuthController.mySignOut();
                  Get.offAll(() => const SigninScreen());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
