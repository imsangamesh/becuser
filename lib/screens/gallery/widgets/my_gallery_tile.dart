import 'package:becuser3/themes/my_colors.dart';
import 'package:becuser3/screens/gallery/widgets/my_event_slider.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class MyGalleryEventTile extends StatelessWidget {
  const MyGalleryEventTile(
    this.eveData, {
    Key? key,
  }) : super(key: key);

  final Map<String, dynamic> eveData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyClr.priClr100,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Text(eveData['title'], style: kNormalSizeBoldTextStyle),
          const SizedBox(height: 5),
          Text(
            '   ${eveData['description']}',
            style: kSmallSizeTextStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 5),
          MyEventSlider(eveData),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
