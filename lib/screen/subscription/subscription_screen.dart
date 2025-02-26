import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_ui_clone/components/custom_listtile.dart';
import 'package:youtube_ui_clone/components/video_card.dart';
import 'package:youtube_ui_clone/item/category_item.dart';
import 'package:youtube_ui_clone/item/setting_item.dart';
import 'package:youtube_ui_clone/screen/notification/notification_screen.dart';
import 'package:youtube_ui_clone/screen/search/search_screen.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class SubscriptionScreen extends StatefulWidget {
  final VoidCallback onNavigate;
  const SubscriptionScreen({Key? key, required this.onNavigate})
    : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late double screenWidth, screenHeight;
  int subscriptionIndex = 0;
  int channelIndex = 0;
  List<dynamic> channel = [];
  List<dynamic> videos = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadJsonData();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 50.0,
            elevation: 0,
            title: SvgPicture.asset("assets/icons/logo.svg"),
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
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ),
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
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [buildChannel(), buildCategory(), buildVideoSection()],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadJsonData() async {
    try {
      String jsonString = await rootBundle.loadString(
        'assets/json/channel.json',
      );
      String jsonVideoString = await rootBundle.loadString(
        'assets/json/video.json',
      );
      List<dynamic> jsonData = jsonDecode(jsonString);
      List<dynamic> jsonVideoData = jsonDecode(jsonVideoString);
      if (mounted) {
        setState(() {
          channel = jsonData;
          videos = jsonVideoData;
        });
      }
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  Widget buildVideoSection() {
    return Column(
      children: List.generate(videos.length, (index) {
        return VideoCard(
          onTap: () {},
          // => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage())),
          videoUrl: videos[index]['videoUrl'],
          duration: videos[index]['duration'],
          title: videos[index]['title'],
          channelProfileUrl: videos[index]['channelProfileUrl'],
          channelName: videos[index]['channelName'],
          view: videos[index]['view'],
          dateTime: videos[index]['dateTime'],
        );
      }),
    );
  }

  Widget buildChannel() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // padding: EdgeInsets.all(MyStyle().defaultSPadding),
      child:
          channel.isEmpty
              ? CircularProgressIndicator()
              : IntrinsicHeight(
                child: Row(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.127,
                      width: screenWidth * 0.85,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        itemCount: channel.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      channel[index]['channelProfileUrl'],
                                    ),
                                    radius: screenHeight * 0.03,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    channel[index]['channelName'],
                                    style: GoogleFonts.roboto(
                                      fontSize: screenHeight * 0.015,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: widget.onNavigate,

                      icon: Text(
                        "All",
                        style: TextStyle(color: MyStyle().blue),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget buildCategory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(
        left: MyStyle().defaultSPadding,
        right: MyStyle().defaultSPadding,
        bottom: MyStyle().defaultSPadding,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(subscriptionItem.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: MyStyle().defaultSPadding),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        subscriptionIndex = index;
                      });
                    },
                    borderRadius: BorderRadius.circular(
                      MyStyle().defaultRadius,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: MyStyle().defaultSPadding - 3,
                        horizontal: MyStyle().defaultPadding,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: MyStyle().white.withOpacity(0.1),
                        ),
                        color:
                            subscriptionIndex == index
                                ? MyStyle().white
                                : MyStyle().grey,
                      ),
                      child: Text(
                        subscriptionItem[index],
                        style: TextStyle(
                          fontSize: screenHeight * 0.013,
                          color:
                              subscriptionIndex == index
                                  ? MyStyle().black
                                  : MyStyle().white,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            IconButton(
              onPressed: onTabSetting,
              icon: Text("Settings", style: TextStyle(color: MyStyle().blue)),
            ),
          ],
        ),
      ),
    );
  }

  onTabSetting() {
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
                    Expanded(
                      child: Text(
                        "What do you want to see in your subscriptions feed?",
                        style: MyStyle().titleStyle,
                        softWrap: true,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MyStyle().defaultSPadding),
              Column(
                children: List.generate(settingItems.length, (index) {
                  return CustomListTile(
                    onTap: () {},
                    leadingIcon: settingItems[index]['icon'],
                    title: settingItems[index]['title'],
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
}
