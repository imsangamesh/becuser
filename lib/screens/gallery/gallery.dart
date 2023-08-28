import 'package:becuser3/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'widgets/my_gallery_tile.dart';

class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: fire.collection('events').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final snapData = snapshot.data as QuerySnapshot;
                    return ListView.builder(
                      itemCount: snapData.docs.length,
                      itemBuilder: (context, index) {
                        final eveData =
                            snapData.docs[index].data() as Map<String, dynamic>;

                        return MyGalleryEventTile(eveData);
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
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

/*

Container(
      width: double.infinity,
      height: size.height * 0.23,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.teal,
          width: 3,
          style: BorderStyle.solid,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: MyClr.apriClr,
          borderRadius: BorderRadius.circular(5),
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              title,
              style: kNormalSizeBoldTextStyle,
            ),
            const SizedBox(height: 10),
            if (loading == true) const CircularProgressIndicator(),
            if (loading == false)
              Text(
                body,
                textAlign: TextAlign.center,
                softWrap: true,
                style: kNormalSizeTextStyle.copyWith(fontSize: 17),
              )
          ]),
        ),
      ),
    );


SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 200,
            ),
            items: _imagePaths
                .map(
                  (image) => Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withAlpha(100),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(image),
                    ),
                  ),
                )
                .toList(),
          ),
        ]),
      ),

      */