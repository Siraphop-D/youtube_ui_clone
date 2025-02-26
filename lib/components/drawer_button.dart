import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_ui_clone/components/navigation_button_desktop.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

List buttons = [
  {
    "isExpanded": false,
    "alignment": Alignment.centerLeft,
    "activeIcon": SvgPicture.asset(
      "assets/icons/home_active.svg",
      color: MyStyle().white,
    ),
    "inactiveIcon": SvgPicture.asset(
      "assets/icons/home.svg",
      color: MyStyle().white,
    ),
    "text": "Home",
  },
  {
    "isExpanded": false,

    "activeIcon": SvgPicture.asset(
      "assets/icons/short_active.svg",
      color: MyStyle().white,
    ),
    "inactiveIcon": SvgPicture.asset(
      "assets/icons/short.svg",
      color: MyStyle().white,
    ),
    "text": "Short",
  },
  {
    "isExpanded": false,
    "alignment": Alignment.centerRight,
    "activeIcon": SvgPicture.asset(
      "assets/icons/subscription_active.svg",
      color: MyStyle().white,
    ),
    "inactiveIcon": SvgPicture.asset(
      "assets/icons/subscription.svg",
      color: MyStyle().white,
    ),
    "text": "Sub",
  },
  {
    "isExpanded": false,
    "activeIcon": SvgPicture.asset(
      "assets/icons/library_active.svg",
      color: MyStyle().white,
    ),
    "inactiveIcon": SvgPicture.asset(
      "assets/icons/library.svg",
      color: MyStyle().white,
    ),
    "text": "Library",
  },
];

List tranding = [
  {
    'icon': Row(
      children: [
        Image.asset("assets/icons/fire.png"),
        SizedBox(width: 10),
        Text('Trending'),
      ],
    ),
    'onPressed': () {},
  },
  {
    'icon': Row(
      children: [
        Image.asset("assets/icons/music.png"),
        SizedBox(width: 10),
        Text('Music'),
      ],
    ),
    'onPressed': () {},
  },
  {
    'icon': Row(
      children: [
        Image.asset("assets/icons/game-console.png"),
        SizedBox(width: 10),
        Text('Gaming'),
      ],
    ),
    'onPressed': () {},
  },
  {
    'icon': Row(
      children: [
        Image.asset("assets/icons/journal.png"),
        SizedBox(width: 10),
        Text('News'),
      ],
    ),
    'onPressed': () {},
  },
  {
    'icon': Row(
      children: [
        Image.asset("assets/icons/trophy.png"),
        SizedBox(width: 10),
        Text('Sports'),
      ],
    ),
    'onPressed': () {},
  },
];

List youtubepp = [
  {
    'icon': Row(
      children: [
        SvgPicture.asset("assets/icons/youtube_studio.svg"),
        SizedBox(width: 10),
        Text('Youtube Studio'),
      ],
    ),
    'onPressed': () {},
  },
  {
    'icon': Row(
      children: [
        SvgPicture.asset("assets/icons/youtube_kid.svg"),
        SizedBox(width: 10),
        Text('Youtube Music'),
      ],
    ),
    'onPressed': () {},
  },
  {
    'icon': Row(
      children: [
        SvgPicture.asset("assets/icons/youtube_kid.svg"),
        SizedBox(width: 10),
        Text('Youtube Kids'),
      ],
    ),
    'onPressed': () {},
  },
];

class Navigation_button extends StatefulWidget {
  const Navigation_button({super.key});

  @override
  State<Navigation_button> createState() => _Navigation_buttonState();
}

class _Navigation_buttonState extends State<Navigation_button> {
  bool isExpanded = false;
  int tabIndex = 0;
  onChangeTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView(
        children: [
          ...navButtons(), // ปุ่ม Navigation
          Divider(thickness: 1, color: MyStyle().white),
          ...trandingButtons(), // ส่วน Trending
          Divider(thickness: 1, color: MyStyle().white),
          ...youtubeAppButtons(), // ส่วน YouTube
        ],
      ),
    );
  }

  // สร้าง Navigation Buttons
  List<Widget> navButtons() {
    return List.generate(buttons.length, (index) {
      return NavigationButtonDesktop(
        onTap: () => onChangeTab(index),
        alignment: buttons[index]['alignment'],
        isActive: tabIndex == index,
        isExpanded: false,
        activeIcon: buttons[index]["activeIcon"],
        inactiveIcon: buttons[index]["inactiveIcon"],
        text: buttons[index]["text"],
      );
    });
  }

  // สร้าง Tranding Buttons
  List<Widget> trandingButtons() {
    return List.generate(tranding.length, (index) {
      return IconButton(
        onPressed: tranding[index]['onPressed'],
        icon: tranding[index]['icon'],
      );
    });
  }

  // สร้าง YoutubeApp Buttons
  List<Widget> youtubeAppButtons() {
    return List.generate(youtubepp.length, (index) {
      return IconButton(
        onPressed: youtubepp[index]['onPressed'],
        icon: youtubepp[index]['icon'],
      );
    });
  }
}
