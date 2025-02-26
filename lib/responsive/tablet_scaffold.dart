import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube_ui_clone/screen/naviscreen/navi_screen.dart';
import 'package:youtube_ui_clone/screen/splash_screen.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({super.key});

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SplashScreen()
    );
  }
}
