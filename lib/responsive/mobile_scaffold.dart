
import 'package:flutter/material.dart';
import 'package:youtube_ui_clone/screen/splash_screen.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}