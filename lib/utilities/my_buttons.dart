import 'package:becuser3/themes/my_colors.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class MyElevButton extends StatelessWidget {
  const MyElevButton(
    this.title,
    this.fun, {
    this.radius,
    this.icon,
    this.textStyle,
    this.buttonStyle,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback fun;
  final double? radius;
  final IconData? icon;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    //
    myElevBtnStyle() =>
        buttonStyle ??
        ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 22),
          textStyle: textStyle ?? kNormalSizeBoldTextStyle,
        );

    return icon == null
        ? ElevatedButton(
            style: myElevBtnStyle(),
            onPressed: () {
              FocusScope.of(context).unfocus();
              fun();
            },
            child: Text(title, style: textStyle),
          )
        : ElevatedButton.icon(
            style: myElevBtnStyle(),
            onPressed: () {
              FocusScope.of(context).unfocus();
              fun();
            },
            icon: Icon(icon),
            label: Text(title, style: textStyle),
          );
  }
}

class MyOutLButton extends StatelessWidget {
  const MyOutLButton(
    this.title,
    this.fun, {
    this.radius,
    this.icon,
    this.textStyle,
    this.buttonStyle,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback fun;
  final double? radius;
  final IconData? icon;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    //
    myOutLBtnStyle() =>
        buttonStyle ??
        OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 5),
          ),
          side: BorderSide(
            color: MyClr.priClr100,
            width: 1.5,
          ),
          textStyle: textStyle ?? kNormalSizeBoldTextStyle,
        );

    return icon == null
        ? OutlinedButton(
            style: myOutLBtnStyle(),
            onPressed: () {
              FocusScope.of(context).unfocus();
              fun();
            },
            child: Text(title, style: textStyle),
          )
        : OutlinedButton.icon(
            style: myOutLBtnStyle(),
            onPressed: () {
              FocusScope.of(context).unfocus();
              fun();
            },
            icon: Icon(icon),
            label: Text(title, style: textStyle),
          );
  }
}
