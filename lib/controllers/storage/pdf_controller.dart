import 'dart:convert';
import 'dart:io';

import 'package:becuser3/models/result_model.dart';
import 'package:becuser3/utilities/myDialogBox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

import '../../constants/constants.dart';

class PDFController {
  //
  static Future<File> generate(Map<String, dynamic> json) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeading(),
        Divider(height: 30),
        SizedBox(height: 20),
        buildMyInfo(json),
        SizedBox(height: 50),
        buildTable(json),
        SizedBox(height: 20),
        Text('SGPA : ${json['sgpa']}'),
      ],
    ));

    return savePdfDocument('${json['usn']}.pdf', pdf);
  }

  static Widget buildHeading() {
    return Column(children: [
      Text(
        'B.V.V.S',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      Text(
        'Basaveshwar Engineering College(Autonomous), Bagalkot',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      Text(
        'BE Provisional Results',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    ]);
  }

  static buildMyInfo(Map<String, dynamic> map) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('USN : ${map['usn']}'),
      SizedBox(height: 5),
      Text('NAME : ${map['name']}'),
      SizedBox(height: 5),
      Text('SEMESTER : ${map['semester']}'),
      SizedBox(height: 5),
      Text('BRANCH : ${map['branch']}'),
    ]);
  }

  static buildTable(Map<String, dynamic> json) {
    List grades = json.values.toList().sublist(6);
    List subData = json.keys.toList().sublist(6);
    List<Subject> subjects = [];
    for (int i = 0; i < subData.length; i++) {
      subjects.add(Subject(
        code: subData[i].toString().split('_')[1].toUpperCase(),
        name: subData[i].toString().split('_')[0].toUpperCase(),
        grade: grades[i],
      ));
    }
    return TableHelper.fromTextArray(
      headers: ['SUBJECT CODE', 'SUBJECT NAME', 'GRADE'],
      data: subjects
          .map((echSM) => [echSM.code, echSM.name, echSM.grade])
          .toList(),
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  // ======================================== save document
  static Future<File> savePdfDocument(String name, Document pdf) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<List<dynamic>> fetchAndSetSemesters(collName) async {
    try {
      final snapData = await fire.collection(collName).get();
      final List semesters = [];
      for (int i = 0; i < snapData.docs.length; i++) {
        final semData = snapData.docs[i].data();
        semesters.add(semData['name'] as String);
      }

      return semesters;
    } catch (e) {
      MyDialogBox.defaultDialog('', e.toString());
      return [];
    }
  }

  static Future<List> fetchResultData(String collName, String doc) async {
    try {
      final snapData = await fire.collection(collName).doc(doc).get();
      final resData = snapData.data() as Map<String, dynamic>;

      final data = json.decode(resData['data']);
      return data;
    } catch (e) {
      MyDialogBox.normalDialog();
      return [];
    }
  }
}
