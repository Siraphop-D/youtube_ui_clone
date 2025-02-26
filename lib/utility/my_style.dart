import 'package:flutter/material.dart';

class MyStyle {
  double defaultXSPadding = 5.0;
  double defaultSPadding = 10.0;
  double defaultPadding = 16.0;
  double defaultLPadding = 20.0;
  double defaultRadius = 16.0;
  Color primary = Color(0xffF60304);
  Color white = Color(0xffffffff);
  Color black = Color(0xff000000);

  Color dark = Color(0xff212121);
  Color grey = Color(0xff383838);
  Color lightGrey = Color(0xff9E9E9E);
  Color blue = Color(0xff58A0DD);

  Color green = Color(0xff07B37D);
  Color orange = Color(0xffF6981A);
  Color red = Color(0xffF73F31);

  TextStyle titleStyle = TextStyle(
    fontSize: 18,
    color: Color(0xffffffff),
    fontWeight: FontWeight.w500,
  );

  TextStyle subTitleStyle = TextStyle(
    fontSize: 16,
    color: Color(0xffffffff),
    fontWeight: FontWeight.w400,
  );

  TextStyle smallStyle = TextStyle(
    fontSize: 12,
    color: Color(0xff9E9E9E),
    fontWeight: FontWeight.normal,
  );

  MyStyle();
}
