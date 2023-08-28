import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import 'my_colors.dart';

class MyTheme {
  //

  static Future<bool> isDark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isdark');
    if (isDark == null) return false;

    if (isDark) {
      return true;
    } else {
      return false;
    }
  }

  static setDark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isdark', true);
  }

  static setLight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isdark', false);
  }

  static myDartTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFF001323),
      primarySwatch: MyClr.myColorsToMaterial(MyColors.blue),
      primaryColor: const Color.fromARGB(255, 0, 41, 74),
      splashColor: Colors.blue.withAlpha(100),
      iconTheme: IconThemeData(color: MyClr.myColorsToMaterial(MyColors.blue)),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 0, 19, 35),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
      ).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusColor: MyClr.apriClr,
        iconColor: MyClr.apriClr,
      ),
      chipTheme: const ChipThemeData(
        labelStyle: TextStyle(color: Colors.white),
      ),
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
    );
  }
}
