import 'package:becuser3/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../utilities/myDialogBox.dart';

class HomeImageController extends GetxController {
  List<dynamic> images = [];

  Future<void> fetchAndUpdateHomeImgs() async {
    try {
      final docSnap =
          await fire.collection('homeimages').doc('homeimages').get();
      final imgData = docSnap.data() as Map<String, dynamic>;

      images = imgData['images'];
      //
    } on FirebaseException catch (e) {
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      MyDialogBox.defaultDialog('oops', e.toString());
    }
    update();
  }
}
