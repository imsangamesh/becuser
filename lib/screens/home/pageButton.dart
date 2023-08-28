import 'package:becuser3/constants/constants.dart';
import 'package:becuser3/themes/my_colors.dart';
import 'package:flutter/material.dart';

class PageButton extends StatelessWidget {
  const PageButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.navigateTo,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function navigateTo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      onTap: () => navigateTo(),
      leading: Icon(icon, size: 30, color: MyClr.apriClr),
      title: Text(title, style: kNormalSizeTextStyle),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Icon(
          Icons.keyboard_double_arrow_right,
          color: MyClr.apriClr,
        ),
      ),
    );
  }
}
