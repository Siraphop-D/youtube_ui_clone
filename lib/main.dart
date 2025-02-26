import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_ui_clone/responsive/desktop_scaffold.dart';
import 'package:youtube_ui_clone/responsive/mobile_scaffold.dart';
import 'package:youtube_ui_clone/responsive/responsive_layout.dart';
import 'package:youtube_ui_clone/responsive/tablet_scaffold.dart';
import 'package:youtube_ui_clone/screen/splash_screen.dart';
import 'package:youtube_ui_clone/screen/subscription/notification_status.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

void main() {
  runApp(BlocProvider(create: (_) => NotificationBloc(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        scaffoldBackgroundColor: MyStyle().dark,
        appBarTheme: AppBarTheme(color: MyStyle().dark, elevation: 0),
        textTheme: TextTheme(bodyMedium: TextStyle(color: MyStyle().white)),
        iconTheme: IconThemeData(color: MyStyle().white),
      ),
      home: ResponsiveLayout(
        mobileScaffold: const MobileScaffold(),
        tabletScaffold: const TabletScaffold(),
        desktopScaffold: const DesktopScaffold(),
      ),
    );
  }
}
