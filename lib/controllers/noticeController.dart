import 'package:becuser3/constants/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utilities/myDialogBox.dart';

class NoticeController extends GetxController {
  String noticeTitle = 'hey there';
  String noticeBody = 'welcome to bec...';
  String noticeDate = '';
  String noticeLink = '';
  List fileUrls = [];
  List imageUrls = [];

  Future<void> fetchAndSetNoticeData() async {
    try {
      final docSnap = await fire.collection('notice').doc('notice').get();
      final notData = docSnap.data() as Map<String, dynamic>;

      noticeTitle = notData['title'];
      noticeBody = notData['body'];
      noticeDate = DateFormat.yMMMd().format(DateTime.parse(notData['date']));
      noticeLink = notData['link'];
      fileUrls = notData['files'];
      imageUrls = notData['images'];
      update();
    } catch (e) {
      MyDialogBox.normalDialog();
    }
  }
}
