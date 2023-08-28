import 'package:becuser3/themes/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';

class MyDrawerListTile extends StatelessWidget {
  const MyDrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.navigateTo,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final dynamic navigateTo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              splashColor: MyClr.priClr100,
              onTap: () {
                Get.back();
                navigateTo();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(icon, size: 32, color: MyClr.apriClr),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      title,
                      style: kNormalSizeTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, height: 8, indent: 10, endIndent: 20),
          ],
        ),
      ),
    );
  }
}
