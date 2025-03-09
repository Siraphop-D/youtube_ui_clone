import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_ui_clone/components/custom_listtile.dart';
import 'package:youtube_ui_clone/item/category_item.dart';
import 'package:youtube_ui_clone/responsive/responsive_layout.dart';
import 'package:youtube_ui_clone/screen/search/search_screen.dart';
import 'package:youtube_ui_clone/screen/videoplayer/videoplayer_screen.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class SportScreen extends StatefulWidget {
  const SportScreen({super.key});

  @override
  State<SportScreen> createState() => _SportScreenState();
}

class _SportScreenState extends State<SportScreen> {
  late double screenWidth, screenHeight;
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
      backgroundColor: MyStyle().dark,
      body: CustomScrollView(
        slivers: [
          ResponsiveLayout.isMobile(context)
              ? buildSliverAppBarMobile(context)
              : buildSliverAppBarTablet(context),
          buildVideoSection(),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBarTablet(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight:
          isPortrait
              ? screenHeight * 0.3
              : screenHeight * 0.4, // ความสูงตอนกางออก
      pinned: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
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
                MaterialPageRoute(builder: (context) => SearchScreen()),
              ),
          splashRadius: 25,
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          splashRadius: 25,
          icon: Icon(Icons.more_vert),
        ),
      ],

      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          double appBarHeight = constraints.biggest.height;
          bool isCollapsed = appBarHeight <= 150;

          return Container(
            decoration: BoxDecoration(color: MyStyle().dark),
            child: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 50, bottom: 15),
              centerTitle: false,
              title:
                  isCollapsed
                      ? const Text(
                        "Sports",
                        style: TextStyle(color: Colors.white),
                      )
                      : null,

              background: buildMainVideo(),
              // Padding(
              //   padding: EdgeInsets.only(
              //     top: screenHeight * 0.07,
              //     left: screenHeight * 0.013,
              //     right: screenHeight * 0.013,
              //   ),
              //   child: Row(
              //     children: [
              //       CircleAvatar(
              //         radius: screenHeight * 0.025,
              //         backgroundImage: AssetImage("assets/icons/sport.jpg"),
              //       ),

              //       SizedBox(width: screenWidth * 0.05),
              //     ],
              //   ),
              // ),
            ),
          );
        },
      ),
    );
  }

  SliverAppBar buildSliverAppBarMobile(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: screenHeight * 0.45, // ความสูงตอนกางออก
      pinned: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
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
                MaterialPageRoute(builder: (context) => SearchScreen()),
              ),
          splashRadius: 25,
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          splashRadius: 25,
          icon: Icon(Icons.more_vert),
        ),
      ],

      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          double appBarHeight = constraints.biggest.height;
          bool isCollapsed = appBarHeight <= 200;

          return Container(
            decoration: BoxDecoration(color: MyStyle().dark),
            child: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 50, bottom: 15),
              centerTitle: false,
              title:
                  isCollapsed
                      ? const Text(
                        "Sports",
                        style: TextStyle(color: Colors.white),
                      )
                      : null,

              background: buildMainVideo(),
              // Padding(
              //   padding: EdgeInsets.only(
              //     top: screenHeight * 0.09,
              //     left: screenWidth * 0.04,
              //     right: screenWidth * 0.013,
              //     bottom: appBarHeight * 0.05,
              //   ),
              //   child: Row(
              //     children: [
              //       CircleAvatar(
              //         radius: screenHeight * 0.03,
              //         backgroundImage: AssetImage("assets/icons/sport.jpg"),
              //       ),
              //       SizedBox(width: screenWidth * 0.05),
              //       Text(
              //         "Sports",
              //         style: TextStyle(
              //           fontSize: screenHeight * 0.018,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ),
          );
        },
      ),
    );
  }

  Widget buildVideoSection() {
    return SliverList(
      delegate: SliverChildListDelegate([
        buildCategorySection(),
        buildLiveSection(),
        buildTrendingVideos(),
      ]),
    );
  }

  Widget buildMainVideo() {
    return CarouselSlider.builder(
      itemCount: videos.length,
      options: CarouselOptions(
        height: screenHeight * 0.58,
        viewportFraction: 1, // ให้เต็มจอ
        autoPlay: true, // เล่นอัตโนมัติ
        autoPlayInterval: Duration(seconds: 5), // เวลาสไลด์
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, index, realIndex) {
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
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              // ภาพพื้นหลังของวิดีโอ
              Container(
                width: double.infinity,
                height: screenHeight * 0.58,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(videos[index]['thumbnail']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // รายละเอียดวิดีโอ
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videos[index]['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${videos[index]['channelName']} • ${videos[index]['views']} views • ${videos[index]['dateTime']}",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCategorySection() {
    return Container(
      color: MyStyle().grey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: screenHeight * 0.025,
                      backgroundImage: AssetImage("assets/icons/sport.jpg"),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sports",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Subscribe",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLiveSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Live", style: TextStyle(color: Colors.white, fontSize: 18)),
              TextButton(
                onPressed: () {},
                child: Text("View all", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height:
              ResponsiveLayout.isMobile(context)
                  ? isPortrait
                      ? screenHeight * 0.28
                      : screenHeight * 0.8
                  : isPortrait
                  ? screenHeight * 0.28
                  : screenHeight * 0.4,

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
        ),
      ],
    );
  }

  Widget buildTrendingVideos() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: List.generate(
          videos.length,
          (index) => InkWell(
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
              padding: EdgeInsets.symmetric(vertical: 5),
              child:
                  ResponsiveLayout.isMobile(context)
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: screenHeight * 0.25,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(videos[index]['thumbnail']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                videos[index]['channelProfile'],
                              ),
                            ),
                            title: Text(
                              videos[index]['title'],
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              "${videos[index]['channelName']} • ${videos[index]['dateTime']}",
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_vert, color: Colors.white),
                            ),
                          ),
                        ],
                      )
                      : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width:
                                isPortrait
                                    ? screenWidth * 0.39
                                    : screenWidth * 0.3,
                            height:
                                isPortrait
                                    ? screenHeight * 0.18
                                    : screenHeight * 0.25,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(videos[index]['thumbnail']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    videos[index]['title'],
                                    maxLines: 2,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${videos[index]['channelName']} • ${videos[index]['view']} views • ${videos[index]['dateTime']}",
                                      style: MyStyle().smallStyle.copyWith(
                                        color: MyStyle().lightGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: MyStyle().defaultLPadding),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                        videos[index]['channelProfile'],
                                      ),
                                    ),
                                    SizedBox(width: MyStyle().defaultSPadding),
                                    Text(
                                      videos[index]['channelName'],
                                      style: TextStyle(color: MyStyle().white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
            ),
          ),
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

  onTabMore() {
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
            children: List.generate(moreItems.length, (index) {
              return CustomListTile(
                onTap: () {},
                leadingIcon: moreItems[index]['icon'],
                title: moreItems[index]['title'],
              );
            }),
          ),
        );
      },
    );
  }
}
