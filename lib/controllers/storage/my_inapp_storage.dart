import 'dart:io';

import 'package:becuser3/screens/questions_and_notes/path_selector.dart';
import 'package:becuser3/utilities/myDialogBox.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class MyInAppStorage {
  //
  static Future<File?> downloadFile(
    Map<String, dynamic> mapDataR,
    SelectMode mode,
  ) async {
    //
    final appStorage = await getApplicationDocumentsDirectory();
    final path = mode == SelectMode.questionPaper
        ? '${appStorage.path}/${mapDataR['dept']}_${mapDataR['sem']}_${mapDataR['sub']}_${mapDataR['testNo']}_${mapDataR['year']}.pdf'
        : '${appStorage.path}/${mapDataR['dept']}_${mapDataR['sem']}_${mapDataR['sub']}_${mapDataR['chapterName']}.pdf';

    final myFile = File(path);

    try {
      MyDialogBox.loading(message: 'downloading...');
      final response = await Dio().get(
        mapDataR['link'],
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
      return myFile;
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
      return null;
    }
  }
}
