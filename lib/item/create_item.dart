
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';


List createItems = [
  {
    "icon": SvgPicture.asset("assets/icons/short.svg", color: MyStyle().white,),
    "title" : "Create a short",
  },
  {
    "icon": Icon(LineIcons.upload),
    "title" : "Upload a video",
  },
  {
    "icon": SvgPicture.asset("assets/icons/live.svg", color: MyStyle().white,),
    "title" : "Go live",
  },
];

