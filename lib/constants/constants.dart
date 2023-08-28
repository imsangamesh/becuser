import 'package:becuser3/themes/my_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final fire = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
final store = FirebaseStorage.instance;

const kErrTextStyle = TextStyle(
  fontSize: 13,
  color: MyClr.errClr,
);

const kGSmallSizeTextStyle = TextStyle(
  fontSize: 15,
  color: Colors.grey,
);

const kGSmallSizeBoldTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);

//////////////////////////////  default  ///////////////////////////

const kNormalSizeTextStyle = TextStyle(
  fontSize: 20,
);

const kSmallSizeTextStyle = TextStyle(
  fontSize: 15,
);

const kSmallSizeBoldTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const kNormalSizeBoldTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kBigSizeTextStyle = TextStyle(
  fontSize: 25,
);

const kBigSizeBoldTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

//////////////////////////////  white  ///////////////////////////

const kWNormalSizeTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
);

const kWNormalSizeBoldTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const kWSmallSizeTextStyle = TextStyle(
  fontSize: 15,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const kWBigSizeTextStyle = TextStyle(
  fontSize: 25,
  color: Colors.white,
);

const kWBigSizeBoldTextStyle = TextStyle(
  fontSize: 25,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

//////////////////////////////  primary  ///////////////////////////

final kPNormalSizeTextStyle = TextStyle(
  fontSize: 20,
  color: MyClr.apriClr,
);

final kPNormalSizeBoldTextStyle = TextStyle(
  fontSize: 20,
  color: MyClr.apriClr,
  fontWeight: FontWeight.bold,
);

final kPSmallSizeTextStyle = TextStyle(
  fontSize: 15,
  color: MyClr.apriClr,
  fontWeight: FontWeight.bold,
);

final kPBigSizeTextStyle = TextStyle(
  fontSize: 25,
  color: MyClr.apriClr,
);

final kPBigSizeBoldTextStyle = TextStyle(
  fontSize: 25,
  color: MyClr.apriClr,
  fontWeight: FontWeight.bold,
);
