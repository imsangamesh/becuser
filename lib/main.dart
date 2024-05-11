import 'package:becuser3/constants/constants.dart';
import 'package:becuser3/controllers/auth/google_auth_controller.dart';
import 'package:becuser3/controllers/auth/profile_controller.dart';
import 'package:becuser3/screens/auth/Four_O_Four.dart';
import 'package:becuser3/screens/auth/signInScreen.dart';
import 'package:becuser3/screens/home/homeScreen.dart';
import 'package:becuser3/themes/my_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/homeimgs_controller.dart';
import 'controllers/noticeController.dart';
import 'themes/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final myPrimColor = await MyClr.getColor();
  final isDark = await MyTheme.isDark();

  final isInAppProfilePresent =
      await ProfileController.fetchAndSetCrntUserData();

  if (isInAppProfilePresent == false) {
    GoogleAuthController.mySignOut();
    runApp(MyApp(const SigninScreen(), myPrimColor, isDark));
    return;
  }
  //
  if (!ProfileController.myInAppUm.isprofilecomplete) {
    runApp(MyApp(const Four0Four(), myPrimColor, isDark));
    return;
  }
  //
  Get.put(NoticeController()).fetchAndSetNoticeData();
  Get.put(HomeImageController()).fetchAndUpdateHomeImgs();
  runApp(MyApp(const HomeScreen(), myPrimColor, isDark));
}

class MyApp extends StatelessWidget {
  const MyApp(this.screen, this.color, this.isDark, {Key? key})
      : super(key: key);
  //
  final dynamic screen;
  final MyColors color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: MyTheme.myDartTheme(context),
      debugShowCheckedModeBanner: false,
      title: 'Becuser',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: MyClr.myColorsToMaterial(color),
        primaryColor: MyClr.myColorsToMaterial(color),
        splashColor: MyClr.priClr100,
        iconTheme: IconThemeData(color: MyClr.myColorsToMaterial(color)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: kNormalSizeBoldTextStyle,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
          ),
        ),
      ),
      navigatorKey: Get.key,
      home: screen,
    );
  }
}


/* shared prefs keys

cuml : current user model
color : primary theme color
isdark : is theme dark


*/