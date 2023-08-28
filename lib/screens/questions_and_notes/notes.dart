import 'package:becuser3/screens/questions_and_notes/path_selector.dart';
import 'package:becuser3/screens/questions_and_notes/questions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'widgets/my_custom_doc_tile.dart';

class Notes extends StatelessWidget {
  const Notes(
    this.path, {
    Key? key,
  }) : super(key: key);

  final String path;

  List<String> getInfo(String id) => id.split('~');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  QuestionPapers.myCustomLabelChip(getInfo(path)[0], context),
                  QuestionPapers.myCustomLabelChip(getInfo(path)[1], context),
                  QuestionPapers.myCustomLabelChip(getInfo(path)[2], context),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Expanded(child: NotesBuilder(path: path)),
          ],
        ),
      ),
    );
  }
}

class NotesBuilder extends StatelessWidget {
  const NotesBuilder({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fire.collection('notes').orderBy('id').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final qstnSnap = snapshot.data as QuerySnapshot;

          if (qstnSnap.docs.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                'Oops!\nNo notes uploaded yet!',
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
                return MyCustomDocTile(qstnData, SelectMode.note);
              } else {
                return null;
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
