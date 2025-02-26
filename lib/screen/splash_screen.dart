import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube_ui_clone/responsive/responsive_layout.dart';
import 'package:youtube_ui_clone/screen/naviscreen/navi_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double screenWidth, screenHeight;
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NaviScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
          ResponsiveLayout.isMobile(context)
              ? Center(
                child: Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.35,
                  child: Lottie.asset(
                    repeat: false,
                    frameRate: FrameRate.max,
                    "assets/lottie/Youtube Splash Screen.json",
                  ),
                ),
              )
              : Center(
                child: Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.35,
                  child: Lottie.asset(
                    repeat: false,
                    fit: BoxFit.contain,
                    frameRate: FrameRate.composition,
                    "assets/lottie/Youtube Splash Screen.json",
                  ),
                ),
              ),
    );
  }
}
