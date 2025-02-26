import 'package:flutter/material.dart';

class NavigationButtonDesktop extends StatelessWidget {
  final String text;
  final Widget activeIcon;
  final Widget inactiveIcon;
  final Alignment? alignment;
  final bool isActive;
  final VoidCallback? onTap;
  final bool isExpanded;
  const NavigationButtonDesktop({
    Key? key,
    required this.text,
    required this.activeIcon,
    required this.inactiveIcon,
    this.alignment = Alignment.center,
    this.isActive = false,
    this.onTap,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    late double screenWidth, screenHeight;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return isExpanded
        ? IconButton(
          onPressed: onTap,
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              isActive ? activeIcon : inactiveIcon,
              Text(text, style: TextStyle(fontSize: screenHeight * 0.01)),
            ],
          ),
        )
        : IconButton(
          onPressed: onTap,
          icon: Row(
            spacing: 0,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              isActive ? activeIcon : inactiveIcon,
              SizedBox(width: screenWidth * 0.007),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontSize: screenHeight * 0.015),
                ),
              ),
            ],
          ),
        );
  }
}
