import 'package:becuser3/constants/constants.dart';
import 'package:becuser3/themes/my_colors.dart';
import 'package:flutter/material.dart';

class DeveloperContact extends StatelessWidget {
  const DeveloperContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyClr.priClr100,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 3),
          SizedBox(
            width: double.infinity,
            child: Text(
              'San & Sajjan',
              textAlign: TextAlign.center,
              style: kBigSizeTextStyle.copyWith(
                fontWeight: FontWeight.w200,
                letterSpacing: 2,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              ' Crackhead ltd.',
              textAlign: TextAlign.center,
              style: kSmallSizeTextStyle.copyWith(
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
