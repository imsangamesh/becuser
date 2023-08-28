import 'package:becuser3/screens/questions_and_notes/path_selector.dart';
import 'package:becuser3/themes/my_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'widgets/my_custom_doc_tile.dart';

class QuestionPapers extends StatelessWidget {
  const QuestionPapers(
    this.path, {
    Key? key,
  }) : super(key: key);

  final String path;

  List<String> getInfo(String id) => id.split('~');

  static myCustomLabelChip(String label, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 8),
      child: Chip(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MyClr.priClr100,
        elevation: 5,
        label: Text(label),
        padding: const EdgeInsets.all(5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Question Papers'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  myCustomLabelChip(getInfo(path)[0], context),
                  myCustomLabelChip(getInfo(path)[1], context),
                  myCustomLabelChip(getInfo(path)[2], context),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Expanded(child: QuestionsFireBuilder(path: path)),
          ],
        ),
      ),
    );
  }
}

class QuestionsFireBuilder extends StatelessWidget {
  const QuestionsFireBuilder({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fire.collection('questionpapers').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final qstnSnap = snapshot.data as QuerySnapshot;

          if (qstnSnap.docs.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                'Oops!\nNo question papers uploaded yet!',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 5),
            itemCount: qstnSnap.docs.length,
            itemBuilder: (context, index) {
              final qstnData =
                  qstnSnap.docs[index].data() as Map<String, dynamic>;

              if (path == qstnData['tag']) {
                return MyCustomDocTile(qstnData, SelectMode.questionPaper);
              } else {
                return const SizedBox();
              }
            },
          );
        } else if (snapshot.hasError) {
          return const Text(
            'an error occured. please notify us while we work on it.',
          );
        } else {
          return const Text('...');
        }
      },
    );
  }
}
