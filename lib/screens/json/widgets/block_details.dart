import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

List<Widget> blockDetails(Map<dynamic, dynamic> mapData) {
  return [
    const SizedBox(height: 20),
    Text(
      'USN : ${mapData['usn']}',
      style: kNormalSizeBoldTextStyle,
    ),
    const SizedBox(height: 5),
    Text(
      'BRANCH : ${mapData['branch'].toString()}',
      style: kNormalSizeBoldTextStyle,
    ),
    const SizedBox(height: 5),
    Text(
      'SEMESTER : ${mapData['semester'].toString()}',
      style: kNormalSizeBoldTextStyle,
    ),
    const SizedBox(height: 5),
    Text(
      'ROLL NO : ${mapData['roll_no'].toString()}',
      style: kNormalSizeBoldTextStyle,
    ),
    const SizedBox(height: 5),
    Text(
      'SEAT NO : ${mapData['seat_no'].toString()}',
      style: kNormalSizeBoldTextStyle,
    ),
    const SizedBox(height: 5),
    Text(
      'BLOCK NO : ${mapData['block_no'].toString()}',
      style: kNormalSizeBoldTextStyle,
    ),
    const SizedBox(height: 5),
  ];
}
