import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/userModel.dart';
import '../constants/constants.dart';
import '../utilities/myDialogBox.dart';

class FirebaseHelper {
  static Future<UserModel?> fetchUserDetailsByUid(String uid) async {
    final DocumentSnapshot userDocumentSnapshot =
        await fire.collection('users').doc(uid).get();

    if (!userDocumentSnapshot.exists) return null;

    final userData = userDocumentSnapshot.data() as Map<String, dynamic>;

    final fetchedUserModel = UserModel(
      uid: uid,
      name: userData['name'],
      profilepic: userData['profilepic'],
      email: userData['email'],
      phone: userData['phone'],
      semester: userData['semester'],
      department: userData['department'],
      isprofilecomplete: userData['isprofilecomplete'],
    );
    return fetchedUserModel;
  }

  static Future<void> uploadUserDataToFirestore(UserModel recUserModel) async {
    MyDialogBox.loading(message: 'processing...');
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(recUserModel.uid)
          .set(recUserModel.toMap());
    } on FirebaseException catch (e) {
      Get.back();
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      MyDialogBox.defaultDialog('OOPS', e.toString());
    }
    Get.back();
  }

  // static Future<bool?> fetchDataAboutUserStatus(String uid) async {
  //   MyDialogBox.loading();
  //   final UserModel? fetchedUserModel =
  //       await FirebaseHelper.fetchUserDetailsByUid(uid);
  //   Get.back();
  //   if (fetchedUserModel == null) return null;

  //   final bool isUserVerified = fetchedUserModel.success;
  //   if (isUserVerified) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
