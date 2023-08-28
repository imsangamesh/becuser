import 'dart:io';

import 'package:becuser3/controllers/storage/my_inapp_storage.dart';
import 'package:becuser3/screens/questions_and_notes/path_selector.dart';
import 'package:becuser3/themes/my_colors.dart';
import 'package:becuser3/utilities/myDialogBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../constants/constants.dart';
import 'my_all_viewers.dart';

class MyCustomDocTile extends StatefulWidget {
  const MyCustomDocTile(this.fireMapData, this.mode, {Key? key})
      : super(key: key);

  final Map<String, dynamic> fireMapData;
  final SelectMode mode;

  @override
  State<MyCustomDocTile> createState() => _MyCustomDocTileState();
}

class _MyCustomDocTileState extends State<MyCustomDocTile> {
  //
  bool _isDownloaded = false;

  List<String> getInfo(String id) => id.split('~');

  downloadAndOpenFile() async {
    final appStorage = await getApplicationDocumentsDirectory();

    if (widget.mode == SelectMode.questionPaper) {
      questionsPDFViewHandler(appStorage);
    } else if (widget.mode == SelectMode.note) {
      notesPDFViewHandler(appStorage);
    }
  }

  Future<File?> _downloadFromSource() async {
    final file = await MyInAppStorage.downloadFile(
      widget.fireMapData,
      widget.mode,
    );
    if (file == null) return null;

    setState(() => _isDownloaded = true);
    return file;
  }

  confirmDelete() {
    MyDialogBox.confirmDialogBox(
      message: 'are you sure that you wanna delete the selected document ?',
      noFun: () => Get.back(),
      noName: 'No',
      yesFun: () => deleteEntity(),
      yesName: 'Yes',
    );
  }

  deleteEntity() async {
    final appStorage = await getApplicationDocumentsDirectory();
    if (widget.mode == SelectMode.questionPaper) {
      final qstnPath =
          '${appStorage.path}/${widget.fireMapData['dept']}_${widget.fireMapData['sem']}_${widget.fireMapData['sub']}_${widget.fireMapData['testNo']}_${widget.fireMapData['year']}.pdf';
      if (File(qstnPath).existsSync()) {
        File(qstnPath).deleteSync();
        setState(() => _isDownloaded = false);
      }
    } else if (widget.mode == SelectMode.note) {
      final notePath =
          '${appStorage.path}/${widget.fireMapData['dept']}_${widget.fireMapData['sem']}_${widget.fireMapData['sub']}_${widget.fireMapData['chapterName']}.pdf';
      if (File(notePath).existsSync()) {
        File(notePath).deleteSync();
        setState(() => _isDownloaded = false);
      }
    }
    Get.back();
  }

  setIsDownloadedTicks() async {
    final appStorage = await getApplicationDocumentsDirectory();
    if (widget.mode == SelectMode.questionPaper) {
      final qstnPath =
          '${appStorage.path}/${widget.fireMapData['dept']}_${widget.fireMapData['sem']}_${widget.fireMapData['sub']}_${widget.fireMapData['testNo']}_${widget.fireMapData['year']}.pdf';
      if (File(qstnPath).existsSync()) setState(() => _isDownloaded = true);
    } else if (widget.mode == SelectMode.note) {
      final notePath =
          '${appStorage.path}/${widget.fireMapData['dept']}_${widget.fireMapData['sem']}_${widget.fireMapData['sub']}_${widget.fireMapData['chapterName']}.pdf';
      if (File(notePath).existsSync()) setState(() => _isDownloaded = true);
    }
  }

  @override
  void initState() {
    setIsDownloadedTicks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Ink(
        decoration: BoxDecoration(
          color: MyClr.priClr50,
          border: Border.all(color: MyClr.priClr100),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () => downloadAndOpenFile(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    '  ${getInfo(widget.fireMapData['id'])[3].capitalize!}',
                    style: kNormalSizeTextStyle.copyWith(color: Colors.pink),
                  ),
                ),
                if (widget.mode == SelectMode.questionPaper)
                  Expanded(
                    child: Text(
                      getInfo(widget.fireMapData['id'])[4],
                      style: kNormalSizeTextStyle,
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    _isDownloaded
                        ? Icons.download_done_rounded
                        : Icons.download_rounded,
                    color: MyClr.apriClr,
                    size: 30,
                  ),
                  onPressed: _downloadFromSource,
                ),
                IconButton(
                  color: MyClr.errClr,
                  disabledColor: Colors.grey,
                  icon: const Icon(Icons.delete, size: 30),
                  onPressed: _isDownloaded ? confirmDelete : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  questionsPDFViewHandler(Directory appStorageDir) async {
    final path =
        '${appStorageDir.path}/${widget.fireMapData['dept']}_${widget.fireMapData['sem']}_${widget.fireMapData['sub']}_${widget.fireMapData['testNo']}_${widget.fireMapData['year']}.pdf';

    if (File(path).existsSync()) {
      Get.to(
        () => MyPdfViewer(File(path),
            '${widget.fireMapData['testNo']}_${widget.fireMapData['year']}'),
      );
    } else {
      final fileR = await _downloadFromSource();
      if (fileR == null) return;

      Get.to(
        () => MyPdfViewer(File(fileR.path),
            '${widget.fireMapData['testNo']}_${widget.fireMapData['year']}'),
      );
    }
  }

  notesPDFViewHandler(Directory appStorageDir) async {
    final path =
        '${appStorageDir.path}/${widget.fireMapData['dept']}_${widget.fireMapData['sem']}_${widget.fireMapData['sub']}_${widget.fireMapData['chapterName']}.pdf';

    if (File(path).existsSync()) {
      Get.to(() =>
          MyPdfViewer(File(path), '${widget.fireMapData['chapterName']}'));
    } else {
      final fileR = await _downloadFromSource();
      if (fileR == null) return;

      Get.to(
        () => MyPdfViewer(
            File(fileR.path), '${widget.fireMapData['chapterName']}'),
      );
    }
  }
}
