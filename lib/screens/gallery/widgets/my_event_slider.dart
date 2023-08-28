import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../event_details.dart';

class MyEventSlider extends StatefulWidget {
  const MyEventSlider(this.eData, {Key? key}) : super(key: key);

  final Map<String, dynamic> eData;

  @override
  State<MyEventSlider> createState() => _MyEventSliderState();
}

class _MyEventSliderState extends State<MyEventSlider> {
  //
  @override
  Widget build(BuildContext context) {
    //
    final List<dynamic> threeImg = [];
    for (int i = 0; i <= 2; i++) {
      if (widget.eData['images'].length >= 3) {
        threeImg.add((widget.eData['images'] as List<dynamic>)[i]);
      }
    }

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.eData['images'].length >= 3
              ? threeImg.length
              : widget.eData['images'].length,
          options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
          itemBuilder: (context, index, realIndex) {
            return Image.network(
              widget.eData['images'].length >= 3
                  ? threeImg[index]
                  : widget.eData['images'][index],
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: SizedBox(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        value: loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () => Get.to(() => EventDetails(widget.eData)),
              child: const Text(
                ' more... ',
                style: kSmallSizeBoldTextStyle,
              ),
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
