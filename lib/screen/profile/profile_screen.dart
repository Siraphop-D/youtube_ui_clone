import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_ui_clone/components/custom_listtile.dart';
import 'package:youtube_ui_clone/item/category_item.dart';
import 'package:youtube_ui_clone/responsive/responsive_layout.dart';
import 'package:youtube_ui_clone/screen/notification/notification_screen.dart';
import 'package:youtube_ui_clone/screen/search/search_screen.dart';
import 'package:youtube_ui_clone/screen/videoplayer/videoplayer_screen.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class ProfileScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const ProfileScreen({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late double screenWidth, screenHeight;
  int profileIndex = 0;
  int settindIndex = 0;
  List<dynamic> videos = [];
  late bool isPortrait;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/json/video.json');
    setState(() {
      videos = jsonDecode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: onTabCast,
            splashRadius: 25,
            icon: Icon(Icons.cast),
          ),
          IconButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                ),

            splashRadius: 25,
            icon: Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                ),
            splashRadius: 25,
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: onTabSetting,
            splashRadius: 25,
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MyStyle().defaultLPadding,
              ),
              child: buildProfile(widget.navigatorKey),
            ),
            buildCategory(),
            buildHistory(widget.navigatorKey),
            buildPlaylist(widget.navigatorKey),
            buildMenuItem(Icons.video_library, "Your videos"),
            buildMenuItem(Icons.download, "Downloads"),
            Divider(thickness: 1, color: MyStyle().lightGrey),
            buildMenuItem(Icons.movie, "Your movies"),
            Divider(thickness: 1, color: MyStyle().lightGrey),
            buildMenuItem(Icons.bar_chart, "Time watched"),
            buildMenuItem(Icons.help_outline, "Help & feedback"),
          ],
        ),
      ),
    );
  }

  buildHistory(GlobalKey<NavigatorState> navigatorKey) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            navigatorKey.currentState!.pushNamed('/history_all');
          },
          child: ListTile(
            title: Text(
              "History",
              style: TextStyle(
                fontSize: screenHeight * 0.016,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 1, color: MyStyle().white),
              ),

              width: screenWidth * 0.2,
              height: screenHeight * 0.03,
              child: Center(
                child: Text(
                  "View all",
                  style: TextStyle(fontSize: screenHeight * 0.015),
                ),
              ),
            ),
          ),
        ),
        buildHistorySection(),
      ],
    );
  }

  buildPlaylist(GlobalKey<NavigatorState> navigatorKey) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            navigatorKey.currentState!.pushNamed('/playlist_all');
          },
          child: ListTile(
            title: Text(
              "Playlists",
              style: TextStyle(
                fontSize: screenHeight * 0.016,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => showCreatePlaylistDialog(),
                  icon: Icon(Icons.add),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: MyStyle().white),
                  ),

                  width: screenWidth * 0.2,
                  height: screenHeight * 0.03,
                  child: Center(
                    child: Text(
                      "View all",
                      style: TextStyle(fontSize: screenHeight * 0.015),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        buildHistorySection()
      ],
    );
  }

  showCreatePlaylistDialog() {
    TextEditingController titleController = TextEditingController();
    String visibility = "Private";
    bool isCollaborate = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: MyStyle().grey,
              content: SizedBox(
                width: screenWidth * 0.89,
                height: screenHeight * 0.32,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New playlist",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: visibility,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items:
                          ["Public", "Private", "Unlisted"].map((
                            String option,
                          ) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() => visibility = value!);
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Collaborate"),
                        Switch(
                          activeColor: MyStyle().dark,
                          activeTrackColor: MyStyle().white,
                          inactiveTrackColor: MyStyle().lightGrey,
                          inactiveThumbColor: MyStyle().dark,
                          value: isCollaborate,
                          onChanged: (value) {
                            setState(() => isCollaborate = value);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: MyStyle().white,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel", style: TextStyle(fontSize: 16)),
                        ),
                        SizedBox(width: screenWidth * 0.015),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyStyle().lightGrey,
                            foregroundColor: MyStyle().white,
                          ),
                          onPressed:
                              titleController.text.isEmpty
                                  ? null
                                  : () {
                                    // Save action here
                                    Navigator.pop(context);
                                  },
                          child: Text(
                            "Create",
                            style: TextStyle(
                              fontSize: 16,
                              color: MyStyle().dark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  buildMenuItem(IconData icon, String title, {Color iconColor = Colors.white}) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: screenHeight * 0.03),
      title: Text(
        title,
        style: TextStyle(fontSize: screenHeight * 0.014, color: iconColor),
      ),
    );
  }

  buildProfile(GlobalKey<NavigatorState> navigatorKey) {
    return InkWell(
      onTap: () {
        navigatorKey.currentState!.pushNamed('/myprofile');
      }, /////
      child: Row(
        children: [
          CircleAvatar(
            radius: screenHeight * 0.045,
            backgroundImage: AssetImage("assets/icons/profile.png"),
          ),
          SizedBox(width: screenWidth * 0.05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name P',
                style: TextStyle(
                  color: MyStyle().white,
                  fontSize: screenHeight * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    '@profilename  •',
                    style: TextStyle(
                      color: MyStyle().white,
                      fontSize: screenHeight * 0.015,
                    ),
                  ),
                  Text(
                    "View channel >",
                    style: TextStyle(
                      color: MyStyle().white,
                      fontSize: screenHeight * 0.015,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHistorySection() {
    return Container(
      width: double.infinity,
      height:
          ResponsiveLayout.isMobile(context)
              ? isPortrait
                  ? screenHeight * 0.29
                  : screenHeight * 0.8
              : isPortrait
              ? screenHeight * 0.28
              : screenHeight * 0.42,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => VideoPlayerScreen(
                        videoUrl: videos[index]['videoUrl'],
                        duration: videos[index]['duration'],
                        title: videos[index]['title'],
                        channelProfile: videos[index]['channelProfile'],
                        channelName: videos[index]['channelName'],
                        view: videos[index]['view'],
                        dateTime: videos[index]['dateTime'],
                        thumbnail: videos[index]['thumbnail'],
                      ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Container(
                width:
                    ResponsiveLayout.isMobile(context)
                        ? isPortrait
                            ? screenWidth * 0.6
                            : screenWidth * 0.4
                        : isPortrait
                        ? screenWidth * 0.502
                        : screenWidth * 0.352,
                height:
                    ResponsiveLayout.isMobile(context)
                        ? isPortrait
                            ? screenHeight * 0.17
                            : screenHeight * 0.3
                        : isPortrait
                        ? screenHeight * 0.2
                        : screenHeight * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width:
                          ResponsiveLayout.isMobile(context)
                              ? isPortrait
                                  ? screenWidth * 0.6
                                  : screenWidth * 0.359
                              : isPortrait
                              ? screenWidth * 0.5
                              : screenWidth * 0.35,
                      height:
                          ResponsiveLayout.isMobile(context)
                              ? isPortrait
                                  ? screenHeight * 0.16
                                  : screenHeight * 0.359
                              : isPortrait
                              ? screenHeight * 0.2
                              : screenHeight * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(videos[index]['thumbnail']),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      videos[index]['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      "${videos[index]['channelName']}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "${videos[index]['view']}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCategory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(MyStyle().defaultSPadding),
      child: IntrinsicHeight(
        child: Row(
          children: List.generate(profileItems.length, (index) {
            return Padding(
              padding: EdgeInsets.only(right: MyStyle().defaultSPadding),
              child: InkWell(
                onTap: () {
                  setState(() {
                    profileIndex = index;
                  });
                },
                borderRadius: BorderRadius.circular(MyStyle().defaultRadius),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: MyStyle().defaultSPadding - 3,
                    horizontal: MyStyle().defaultPadding,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      MyStyle().defaultRadius,
                    ),
                    border: Border.all(
                      width: 1,
                      color: MyStyle().white.withOpacity(0.1),
                    ),
                    color:
                        profileIndex == index
                            ? MyStyle().white
                            : MyStyle().grey,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        profileItems[index]["icon"],
                        color:
                            profileIndex == index
                                ? MyStyle().black
                                : MyStyle().white,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        profileItems[index]["title"],
                        style: TextStyle(
                          fontSize: screenHeight * 0.014,
                          color:
                              profileIndex == index
                                  ? MyStyle().black
                                  : MyStyle().white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  onTabCast() {
    showModalBottomSheet(
      context: context,
      backgroundColor: MyStyle().dark,
      barrierColor: MyStyle().black.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MyStyle().defaultRadius),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: MyStyle().defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: MyStyle().defaultSPadding),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MyStyle().defaultPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select a device", style: MyStyle().titleStyle),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MyStyle().defaultSPadding),
              Column(
                children: List.generate(castItems.length, (index) {
                  return CustomListTile(
                    onTap: () {},
                    leadingIcon: castItems[index]['icon'],
                    title: castItems[index]['title'],
                  );
                }),
              ),
              SizedBox(height: MyStyle().defaultLPadding),
            ],
          ),
        );
      },
    );
  }

  onTabSetting() {
    showModalBottomSheet(
      context: context,
      backgroundColor: MyStyle().dark,
      barrierColor: MyStyle().black.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(MyStyle().defaultRadius),
        ),
      ),
      isScrollControlled: true, // ให้ BottomSheet ปรับขนาดตามเนื้อหา
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.98, 
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: MyStyle().defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MyStyle().defaultSPadding),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MyStyle().defaultPadding,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text("Settings", style: MyStyle().titleStyle),
                    ],
                  ),
                ),

                SizedBox(height: MyStyle().defaultSPadding),
                Expanded(
                  child: ListView.separated(
                    itemCount: settingsItems.length,
                    separatorBuilder: (context, index) {
    

                      if (index == 9) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MyStyle().defaultSPadding,
                            horizontal: MyStyle().defaultPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(color: Colors.white.withOpacity(0.1)),
                              Text(
                                "Video and audio preferrences", 
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (index == 15) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MyStyle().defaultSPadding,
                            horizontal: MyStyle().defaultPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(color: Colors.white.withOpacity(0.1)),
                              Text(
                                "Help and policies", 
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Spacer();
                    },
                    itemBuilder: (context, index) {
                      return CustomListTile(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => settingsItems[index]['onTap'],
                              ),
                            ),

                        leadingIcon: settingsItems[index]['icon'],
                        title: settingsItems[index]['title'],
                      );
                    },
                  ),
                ),

                SizedBox(height: MyStyle().defaultLPadding),
              ],
            ),
          ),
        );
      },
    );
  }
}
