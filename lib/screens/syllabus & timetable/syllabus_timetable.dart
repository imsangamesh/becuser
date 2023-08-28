import 'dart:io';

import 'package:becuser3/constants/constants.dart';
import 'package:becuser3/controllers/auth/profile_controller.dart';
import 'package:becuser3/screens/questions_and_notes/widgets/my_all_viewers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../utilities/myDialogBox.dart';

class SyllabusAndTimetable extends StatelessWidget {
  const SyllabusAndTimetable({Key? key}) : super(key: key);

  static downloadOrOpenFile(String type) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final searchDocName =
        '${ProfileController.myInAppUm.department}~${ProfileController.myInAppUm.semester}';

    if (File('${appStorage.path}$searchDocName~$type.pdf').existsSync()) {
      Get.to(() => MyPdfViewer(
          File('${appStorage.path}$searchDocName~$type.pdf'), 'My $type'));
      return;
    }

    final docSnap = await fire.collection(type).doc(searchDocName).get();
    final snapData = docSnap.data() as Map<String, dynamic>;

    final myFile = File('${appStorage.path}$searchDocName~$type.pdf');

    try {
      MyDialogBox.loading(message: 'downloading...');
      final response = await Dio().get(
        snapData['link'],
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      final storeRef = myFile.openSync(mode: FileMode.write);
      storeRef.writeFromSync(response.data);
      await storeRef.close();

      Get.back();
      MyDialogBox.showSnackBar('downloaded', yes: true);
      Get.to(() => MyPdfViewer(
          File('${appStorage.path}$searchDocName~$type.pdf'), 'My $type'));
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
