import 'package:aalbaya/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final double width = 540.w;
final double height = 1100.h;
final double textsize = 60.sp;

final headstyle = TextStyle(
    fontSize: textsize, fontWeight: FontWeight.bold, color: Colors.black);

final subheadstyle =
    TextStyle(fontSize: textsize * 0.85, fontWeight: FontWeight.bold);

final contentstyle = TextStyle(fontSize: textsize * 0.75, color: Colors.black);

final contentpointstyle = TextStyle(
    fontSize: textsize * 0.75, color: pointcolor, fontWeight: FontWeight.bold);

final pointstyle = TextStyle(
    fontWeight: FontWeight.bold, color: pointcolor, fontSize: textsize * 0.75);

final formbuilderstyle = TextStyle(fontSize: textsize * 0.85, height: 1);

final formbuilderhintstyle = TextStyle(
    fontSize: textsize * 0.85, color: Colors.black.withOpacity(0.2), height: 1);

final listtextstyle = TextStyle(
  fontSize: textsize * 0.74,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
