import 'dart:developer';

import 'package:becuser3/constants/constants.dart';
import 'package:becuser3/models/userModel.dart';
import 'package:becuser3/screens/home/homeScreen.dart';
import 'package:becuser3/themes/my_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/firebase_helper.dart';
import '../../main.dart';
import '../../themes/my_colors.dart';
import '../../utilities/myDialogBox.dart';
import '../homeimgs_controller.dart';
import '../noticeController.dart';

class ProfileController {
  //
  static UserModel myInAppUm = UserModel(
    uid: '',
    name: '',
    profilepic: '',
    email: '',
    phone: '',
    semester: '',
    department: '',
    isprofilecomplete: false,
  );

  static uploadUserDataAndComplete(
    String id,
    String name,
    String imageUrl,
    String email,
    String phone,
    String sem,
    String dept,
  ) async {
    try {
      MyDialogBox.loading();

      UserModel newlyCompletedUserModel = UserModel(
        uid: id,
        name: name,
        profilepic: imageUrl,
        email: email,
        phone: phone,
        semester: sem,
        department: dept,
        isprofilecomplete: true,
      );

      myInAppUm = newlyCompletedUserModel;
      Get.offAll(() => const HomeScreen());
      final myPrimColor = await MyClr.getColor();

      Get.put(NoticeController()).fetchAndSetNoticeData();
      Get.put(HomeImageController()).fetchAndUpdateHomeImgs();
      runApp(MyApp(const HomeScreen(), myPrimColor, await MyTheme.isDark()));

      // updating firestore
      await fire
          .collection('users')
          .doc(newlyCompletedUserModel.uid)
          .set(newlyCompletedUserModel.toMap());

      // updating shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('cuml', newlyCompletedUserModel.toList());
      //
    } on FirebaseException catch (e) {
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      MyDialogBox.defaultDialog('OOPS', e.toString());
    }
  }

  static setUserData(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('cuml', userModel.toList());

    myInAppUm = userModel;
  }

  static Future<bool> fetchAndSetCrntUserData() async {
    if (auth.currentUser == null) return false;
    log('======fetching in app=======');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userModelList = prefs.getStringList('cuml');

    if (userModelList == null) {
      log('======fetching from server=======');
      final serverFetchedUserModel =
          await FirebaseHelper.fetchUserDetailsByUid(auth.currentUser!.uid);
      if (serverFetchedUserModel == null) return false;

      myInAppUm = serverFetchedUserModel;
      return true;
    }

    myInAppUm = UserModel.fromList(userModelList);
    return true;
  }
}
