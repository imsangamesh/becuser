import 'package:becuser3/constants/constants.dart';
import 'package:becuser3/screens/others/widgets/facultyListTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Faculty extends StatelessWidget {
  const Faculty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
        appBar: AppBar(title: const Text('Faculty')),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: StreamBuilder(
            stream: fire.collection('faculty').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                final snapData = (snapshot.data as QuerySnapshot);
                return ListView.builder(
                  itemCount: snapData.docs.length,
                  itemBuilder: (context, index) {
                    final facData =
                        snapData.docs[index].data() as Map<String, dynamic>;
                    return FacultyListTile(
                      name: facData['name'],
                      designation: facData['desgn'],
                      phone: facData['phone'],
                      myEmail: facData['email'],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('an error occured !'));
              } else {
                return const Center(child: Text('no data found'));
              }
            },
          ),
        ));
  }
}
