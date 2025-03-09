import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:youtube_ui_clone/responsive/responsive_layout.dart';

class NavigationButton extends StatelessWidget {
  final String text;
  final Widget activeIcon;
  final Widget inactiveIcon;
  final Alignment? alignment;
  final bool isActive;
  final VoidCallback? onTap;

  const NavigationButton({
    Key? key,
    required this.text,
    required this.activeIcon,
    required this.inactiveIcon,
    this.alignment = Alignment.center,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late double screenHeight;
    screenHeight = MediaQuery.of(context).size.height;
    return ResponsiveLayout.isMobile(context)
        ? IconButton(
          onPressed: onTap,
          padding: EdgeInsets.all(2),
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              isActive ? activeIcon : inactiveIcon,
              Text(text, style: TextStyle(fontSize: screenHeight * 0.01)),
            ],
          ),
        )
        : IconButton(
          onPressed: onTap,
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              isActive ? activeIcon : inactiveIcon,
              Text(text, style: TextStyle(fontSize: screenHeight * 0.01)),
            ],
          ),
        );
  }
}
