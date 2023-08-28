import 'package:becuser3/screens/notice/notice_details.dart';
import 'package:becuser3/themes/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard(
    this.title,
    this.body,
    this.date,
    this.imageUrls,
    this.fileUrls,
    this.link, {
    Key? key,
    this.loading = false,
  }) : super(key: key);

  final String title, body, date, link;
  final List imageUrls, fileUrls;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: MyClr.apriClr,
              width: 3,
              style: BorderStyle.solid,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: MyClr.priClr100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '   $title',
                      maxLines: 1,
                      style: kNormalSizeBoldTextStyle,
                    ),
                  ),
                  Text('$date ', style: kSmallSizeBoldTextStyle),
                ],
              ),
              const SizedBox(height: 10),
              if (loading == true) const CircularProgressIndicator(),
              if (loading == false)
                Expanded(
                  child: Text(
                    body,
                    textAlign: TextAlign.center,
                    style: kNormalSizeTextStyle.copyWith(fontSize: 17),
                  ),
                )
            ]),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: MyClr.apriClr,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.keyboard_double_arrow_right),
              color: Colors.white,
              onPressed: () => Get.to(
                () => NoticeDetailsScreen(
                    title, body, date, imageUrls, fileUrls, link),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
