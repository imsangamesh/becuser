import 'package:becuser3/themes/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../screens/home/homeScreen.dart';

enum MyColors {
  teal,
  purple,
  pink,
  amber,
  blue,
  red,
  deeppurple,
  indigo,
  cyan,
  green,
  lime,
  yellow,
  deepOrange,
  blueGrey,
}

class MyClr {
  //
  static setColor(MyColors clrR, bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('color', clrR.toString());

    if (isDark) {
      MyTheme.setDark();
      apriClr = Colors.blue;
      priClr100 = const Color.fromARGB(255, 0, 41, 74);
      priClr50 = const Color.fromARGB(255, 0, 85, 155);

      runApp(MyApp(const HomeScreen(), clrR, true));
      Get.offAll(() => const HomeScreen());
      // ------------ dark theme set
    } else {
      MyTheme.setLight();

      if (clrR == MyColors.pink) {
        apriClr = Colors.pink;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.purple) {
        apriClr = Colors.purple;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.amber) {
        apriClr = Colors.amber;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.blue) {
        apriClr = Colors.blue;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.red) {
        apriClr = Colors.red;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.deeppurple) {
        apriClr = Colors.deepPurple;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.indigo) {
        apriClr = Colors.indigo;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.cyan) {
        apriClr = Colors.cyan;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.green) {
        apriClr = Colors.green;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.lime) {
        apriClr = Colors.lime;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.yellow) {
        apriClr = Colors.yellow;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.deepOrange) {
        apriClr = Colors.deepOrange;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.blueGrey) {
        apriClr = Colors.blueGrey;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      } else if (clrR == MyColors.teal) {
        apriClr = Colors.teal;
        priClr100 = apriClr.shade100;
        priClr50 = apriClr.shade50;
      }
      runApp(MyApp(const HomeScreen(), clrR, false));
    }

    Get.offAll(() => const HomeScreen());
  }

  static Future<MyColors> getColor() async {
    // ------------ check dark
    if (await MyTheme.isDark()) {
      apriClr = Colors.blue;
      priClr100 = const Color.fromARGB(255, 0, 41, 74);
      priClr50 = const Color.fromARGB(255, 0, 72, 131);

      return MyColors.blue;
    }

    final prefs = await SharedPreferences.getInstance();
    final color = prefs.getString('color');
    if (color == null) return MyColors.teal;

    switch (color) {
      case 'MyColors.pink':
        apriClr = Colors.pink;
        return MyColors.pink;
      case 'MyColors.purple':
        apriClr = Colors.purple;
        return MyColors.purple;
      case 'MyColors.amber':
        apriClr = Colors.amber;
        return MyColors.amber;
      case 'MyColors.blue':
        apriClr = Colors.blue;
        return MyColors.blue;
      case 'MyColors.red':
        apriClr = Colors.red;
        return MyColors.red;
      case 'MyColors.deeppurple':
        apriClr = Colors.deepPurple;
        return MyColors.deeppurple;
      case 'MyColors.indigo':
        apriClr = Colors.indigo;
        return MyColors.indigo;
      case 'MyColors.cyan':
        apriClr = Colors.cyan;
        return MyColors.cyan;
      case 'MyColors.green':
        apriClr = Colors.green;
        return MyColors.green;
      case 'MyColors.lime':
        apriClr = Colors.lime;
        return MyColors.lime;
      case 'MyColors.yellow':
        apriClr = Colors.yellow;
        return MyColors.yellow;
      case 'MyColors.deepOrange':
        apriClr = Colors.deepOrange;
        return MyColors.deepOrange;
      case 'MyColors.blueGrey':
        apriClr = Colors.blueGrey;
        return MyColors.blueGrey;
      case 'MyColors.teal':
        apriClr = Colors.teal;
        return MyColors.teal;
      default:
        return MyColors.teal;
    }
  }

  static MyColors materialToMyColors(MaterialColor matColor) {
    if (matColor == Colors.pink) {
      return MyColors.pink;
    } else if (matColor == Colors.purple) {
      return MyColors.purple;
    } else if (matColor == Colors.amber) {
      return MyColors.amber;
    } else if (matColor == Colors.blue) {
      return MyColors.blue;
    } else if (matColor == Colors.red) {
      return MyColors.red;
    } else if (matColor == Colors.deepPurple) {
      return MyColors.deeppurple;
    } else if (matColor == Colors.indigo) {
      return MyColors.indigo;
    } else if (matColor == Colors.cyan) {
      return MyColors.cyan;
    } else if (matColor == Colors.green) {
      return MyColors.green;
    } else if (matColor == Colors.lime) {
      return MyColors.lime;
    } else if (matColor == Colors.yellow) {
      return MyColors.yellow;
    } else if (matColor == Colors.deepOrange) {
      return MyColors.deepOrange;
    } else if (matColor == Colors.blueGrey) {
      return MyColors.blueGrey;
    } else if (matColor == Colors.teal) {
      return MyColors.teal;
    } else {
      return MyColors.teal;
    }
  }

  static MaterialColor myColorsToMaterial(MyColors myColors) {
    switch (myColors) {
      case MyColors.pink:
        return Colors.pink;
      case MyColors.amber:
        return Colors.amber;
      case MyColors.purple:
        return Colors.purple;
      case MyColors.blue:
        return Colors.blue;
      case MyColors.red:
        return Colors.red;
      case MyColors.deeppurple:
        return Colors.deepPurple;
      case MyColors.indigo:
        return Colors.indigo;
      case MyColors.cyan:
        return Colors.cyan;
      case MyColors.green:
        return Colors.green;
      case MyColors.lime:
        return Colors.lime;
      case MyColors.yellow:
        return Colors.yellow;
      case MyColors.deepOrange:
        return Colors.deepOrange;
      case MyColors.blueGrey:
        return Colors.blueGrey;
      default:
        return Colors.teal;
    }
  }

  static List<MyColors> get listOfOtherThemes {
    final themes = MyColors.values
        .where((element) => element != MyClr.materialToMyColors(MyClr.apriClr))
        .toList();
    themes.remove(MyClr.materialToMyColors(MyClr.apriClr));
    return themes;
  }

  // primary color
  static MaterialColor apriClr = Colors.teal;

  // shades of primary color
  static Color priClr50 = apriClr.shade50;
  static Color priClr100 = apriClr.shade100;

  // indicator color
  static const crctClr = Colors.teal;
  static const alrtClr = Colors.amber;
  static const errClr = Colors.red;
}
