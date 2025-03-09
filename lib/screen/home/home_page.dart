import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youtube_ui_clone/components/custom_listtile.dart';
import 'package:youtube_ui_clone/components/video_card.dart';
import 'package:youtube_ui_clone/item/category_item.dart';
import 'package:youtube_ui_clone/responsive/responsive_layout.dart';
import 'package:youtube_ui_clone/screen/naviscreen/navi_screen.dart';
import 'package:youtube_ui_clone/screen/notification/notification_screen.dart';
import 'package:youtube_ui_clone/screen/search/search_screen.dart';
import 'package:youtube_ui_clone/screen/videoplayer/videoplayer_screen.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double screenWidth, screenHeight;
  int categoryIndex = 0;
  List<dynamic> videos = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool isPortrait;
  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 50.0,
            automaticallyImplyLeading: false,
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
            child: Column(children: [buildCategory(), buildVideoSection()]),
          ),
        ],
      ),
    );
  }

  Widget buildCategory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(MyStyle().defaultSPadding),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  MyStyle().defaultRadius / 4,
                ),
                color: MyStyle().grey,
              ),
              child: IconButton(
                onPressed: () {
                  NaviScreen.scaffoldKey.currentState?.openDrawer();
                },
                icon: Icon(LineIcons.compass),
                alignment: Alignment.center,
              ),
            ),
            SizedBox(width: MyStyle().defaultSPadding * 2),
            Row(
              children: List.generate(categoryItems.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: MyStyle().defaultSPadding),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        categoryIndex = index;
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
                        borderRadius: BorderRadius.circular(
                          MyStyle().defaultRadius,
                        ),
                        border: Border.all(
                          width: 1,
                          color: MyStyle().white.withOpacity(0.1),
                        ),
                        color:
                            categoryIndex == index
                                ? MyStyle().white
                                : MyStyle().grey,
                      ),
                      child: Text(
                        categoryItems[index],
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              categoryIndex == index
                                  ? MyStyle().black
                                  : MyStyle().white,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/json/video.json');
    setState(() {
      videos = jsonDecode(jsonString);
    });
  }

  Widget buildVideoSection() {
    return ResponsiveLayout.isMobile(context)
        ? Column(
          children: List.generate(videos.length, (index) {
            return VideoCard(
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
              videoUrl: videos[index]['videoUrl'],
              duration: videos[index]['duration'],
              title: videos[index]['title'],
              channelProfile: videos[index]['channelProfile'],
              channelName: videos[index]['channelName'],
              view: videos[index]['view'],
              dateTime: videos[index]['dateTime'],
              thumbnail: videos[index]['thumbnail'],
            );
          }),
        )
        : LayoutBuilder(
          builder: (context, constrains) {
            int crossAxisCount = constrains.maxWidth > 900 ? 3 : 2;
            return Padding(
              padding: EdgeInsets.all(8),
              child:
                  videos != null &&
                          videos
                              .isNotEmpty // เช็คว่า videos มีค่า
                      ? Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                                mainAxisExtent:
                                    constrains.maxWidth > 900
                                        ? isPortrait
                                            ? screenHeight * 0.25
                                            : screenHeight * 0.41
                                        : screenHeight * 0.3,
                                childAspectRatio: 16 / 9,
                              ),
                          itemCount: videos.length,
                          itemBuilder: (context, index) {
                            return VideoCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => VideoPlayerScreen(
                                          videoUrl: videos[index]['videoUrl'],
                                          duration: videos[index]['duration'],
                                          title: videos[index]['title'],
                                          channelProfile:
                                              videos[index]['channelProfile'],
                                          channelName:
                                              videos[index]['channelName'],
                                          view: videos[index]['view'],
                                          dateTime: videos[index]['dateTime'],
                                          thumbnail: videos[index]['thumbnail'],
                                        ),
                                  ),
                                );
                              },
                              videoUrl: videos[index]['videoUrl'],
                              duration: videos[index]['duration'],
                              title: videos[index]['title'],
                              channelProfile: videos[index]['channelProfile'],
                              channelName: videos[index]['channelName'],
                              view: videos[index]['view'],
                              dateTime: videos[index]['dateTime'],
                              thumbnail: videos[index]['thumbnail'],
                            );
                          },
                        ),
                      )
                      : Center(child: CircularProgressIndicator()),
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
