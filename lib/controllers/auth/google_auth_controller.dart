import 'package:becuser3/controllers/auth/profile_controller.dart';
import 'package:becuser3/helpers/firebase_helper.dart';
import 'package:becuser3/screens/auth/profile_fill_up_screen.dart';
import 'package:becuser3/screens/home/homeScreen.dart';
import 'package:becuser3/themes/my_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../../main.dart';
import '../../models/userModel.dart';
import '../../themes/my_theme.dart';
import '../../utilities/myDialogBox.dart';
import '../homeimgs_controller.dart';
import '../noticeController.dart';

class GoogleAuthController {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      // // checking whether email is among the valid_users or not
      // final validUsersData =
      //     await fire.collection('valid_users').doc('valid_users').get();
      // final validUsersList = validUsersData.data() == null
      //     ? []
      //     : validUsersData.data()!['valid_users'];

      // if (!validUsersList.contains(googleSignInAccount.email)) {
      //   googleSignIn.signOut();
      //   MyDialogBox.defaultDialog(
      //     'Oops!',
      //     'selected email is not authorised by college... please provide the email you\'ve given while college admission',
      //   );
      //   return;
      // }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      if (userCredential.user == null) return;

      final user = userCredential.user;
      if (user == null) return;

      // checking whether is new or was already signed in once
      final userStat = await fetchUserStatus(user.uid);

      if (userStat == null || userStat == false) {
        createNewUser(user); // creating new account
      } else {
        final befUserModel =
            await FirebaseHelper.fetchUserDetailsByUid(user.uid);

        if (befUserModel == null || befUserModel.isprofilecomplete == false) {
          createNewUser(user);
          return;
        }

        ProfileController.setUserData(befUserModel);
        final myPrimColor = await MyClr.getColor();

        Get.put(NoticeController()).fetchAndSetNoticeData();
        Get.put(HomeImageController()).fetchAndUpdateHomeImgs();
        runApp(MyApp(const HomeScreen(), myPrimColor, await MyTheme.isDark()));
        Get.offAll(() => const HomeScreen());
      }

      //
    } on FirebaseAuthException catch (e) {
      MyDialogBox.defaultDialog(
        e.code,
        e.message.toString(),
      );
    } catch (e) {
      MyDialogBox.defaultDialog('Note', e.toString());
    }
  }

  createNewUser(User user) async {
    final newUserModel = UserModel(
      uid: user.uid,
      name: '',
      profilepic: user.photoURL,
      email: user.email,
      phone: user.phoneNumber ?? '',
      semester: null,
      department: null,
      isprofilecomplete: false,
    );

    ProfileController.myInAppUm = newUserModel;
    await FirebaseHelper.uploadUserDataToFirestore(newUserModel);

    Get.to(() => ProfileFillUpScreen(newUserModel));
  }

  static Future<bool?> fetchUserStatus(String uid) async {
    MyDialogBox.loading();
    final UserModel? fetchedUserModel =
        await FirebaseHelper.fetchUserDetailsByUid(uid);
    if (fetchedUserModel == null) return null;
    Get.back();

    return fetchedUserModel.isprofilecomplete;
  }

  static myAnonymousSignin() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      final user = userCredential.user;

      final newUserModel = UserModel(
        uid: user!.uid,
        name: 'guest',
        profilepic:
            'https://img.freepik.com/premium-psd/3d-cartoon-avatar-smiling-man_1020-5130.jpg?size=338&ext=jpg&uid=R65626931&ga=GA1.2.1025021015.1655558182&semt=sph',
        email: 'guest@gmail.com',
        phone: '',
        semester: null,
        department: null,
        isprofilecomplete: false,
      );

      ProfileController.myInAppUm = newUserModel;

      await FirebaseHelper.uploadUserDataToFirestore(newUserModel);
      Get.to(() => ProfileFillUpScreen(newUserModel));
      //
    } on FirebaseAuthException catch (e) {
      MyDialogBox.defaultDialog('OOPS', e.message.toString());
    } catch (e) {
      if (e.toString() == 'Null check operator used on a null value') {
        MyDialogBox.showSnackBar('Please select your email to proceed!');
      } else {
        MyDialogBox.normalDialog();
      }
    }
  }

  static mySignOut() async {
    try {
      await deleteAnonymousUserData();
      await GoogleSignIn().signOut();
    } catch (e) {}
    await FirebaseAuth.instance.signOut();
  }

  static deleteAnonymousUserData() async {
    final um =
        await FirebaseHelper.fetchUserDetailsByUid(auth.currentUser!.uid);
    if (um == null) return;
    if (um.email != 'guest@gmail.com') return;

    try {
      fire.collection('users').doc(auth.currentUser!.uid).delete();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('cuml');
      prefs.clear();
      auth.currentUser!.delete();
    } catch (e) {}
  }
}
