import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:youtube_ui_clone/components/custom_listtile.dart';
import 'package:youtube_ui_clone/item/category_item.dart';
import 'package:youtube_ui_clone/responsive/responsive_layout.dart';
import 'package:youtube_ui_clone/screen/search/search_screen.dart';
import 'package:youtube_ui_clone/screen/videoplayer/videoplayer_screen.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: MyStyle().dark,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              ResponsiveLayout.isMobile(context)
                  ? buildSliverAppBarMobile(context)
                  : buildSliverAppBarTablet(context),
            ];
          },
          body: TabBarView(
            children: [
              buildVideoSection(),
              buildVideoSection(),
              buildVideoSection(),
              buildVideoSection(),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppBarTablet(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight:
          isPortrait
              ? screenHeight * 0.15
              : screenHeight * 0.18, // ความสูงตอนกางออก
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
              titlePadding: const EdgeInsets.only(left: 50, bottom: 62),
              centerTitle: false,
              title:
                  isCollapsed
                      ? const Text(
                        "News",
                        style: TextStyle(color: Colors.white),
                      )
                      : null,

              background: Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.03,
                  left: screenHeight * 0.013,
                  right: screenHeight * 0.013,
                ),
                child: Row(
                  children: [
                    Text(
                      "News",
                      style: TextStyle(
                        fontSize:
                            isPortrait
                                ? screenHeight * 0.018
                                : screenHeight * 0.024,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottom: const TabBar(
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        tabs: [
          Tab(text: "Top Stories"),
          Tab(text: "Sport"),
          Tab(text: "Entertainment"),
          Tab(text: "Business"),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBarMobile(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: screenHeight * 0.19, // ความสูงตอนกางออก
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
          bool isCollapsed = appBarHeight <= 190;

          return Container(
            decoration: BoxDecoration(color: MyStyle().dark),
            child: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 50, bottom: 62),
              centerTitle: false,
              title:
                  isCollapsed
                      ? const Text(
                        "News",
                        style: TextStyle(color: Colors.white),
                      )
                      : null,

              background: Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.09,
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.013,
                  bottom: appBarHeight * 0.05,
                ),
                child: Row(
                  children: [
                    Text(
                      "News",
                      style: TextStyle(
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottom: const TabBar(
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        tabs: [
          Tab(text: "Top Stories"),
          Tab(text: "Sport"),
          Tab(text: "Entertainment"),
          Tab(text: "Business"),
        ],
      ),
    );
  }

  Widget buildVideoSection() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Live now: News Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Live now: News",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height:
                      isPortrait
                          ? screenHeight * 0.23
                          : screenHeight * 0.3, // ความสูงของแถวเลื่อน
                  child:
                      videos.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                            scrollDirection: Axis.horizontal, // ให้เลื่อนแนวนอน
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
                                            channelProfile:
                                                videos[index]['channelProfile'],
                                            channelName:
                                                videos[index]['channelName'],
                                            view: videos[index]['view'],
                                            dateTime: videos[index]['dateTime'],
                                            thumbnail:
                                                videos[index]['thumbnail'],
                                          ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Container(
                                    width:
                                        isPortrait
                                            ? screenWidth * 0.4
                                            : screenWidth * 0.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              isPortrait
                                                  ? screenWidth * 0.4
                                                  : screenWidth * 0.3,
                                          height:
                                              isPortrait
                                                  ? screenHeight * 0.12
                                                  : screenHeight * 0.18,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                videos[index]['thumbnail'],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          width: screenWidth * 0.4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                videos[index]['title'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      screenHeight * 0.016,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${videos[index]['channelName']}",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                "${videos[index]['view']}",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
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
            ),
            SizedBox(height: 20),
            videos.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Column(
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
                                  channelProfile:
                                      videos[index]['channelProfile'],
                                  channelName: videos[index]['channelName'],
                                  view: videos[index]['view'],
                                  dateTime: videos[index]['dateTime'],
                                  thumbnail: videos[index]['thumbnail'],
                                ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
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
                                          image: AssetImage(
                                            videos[index]['thumbnail'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
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
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                          image: AssetImage(
                                            videos[index]['thumbnail'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.01),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                style: MyStyle().smallStyle
                                                    .copyWith(
                                                      color:
                                                          MyStyle().lightGrey,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MyStyle().defaultLPadding,
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage: AssetImage(
                                                  videos[index]['channelProfile'],
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    MyStyle().defaultSPadding,
                                              ),
                                              Text(
                                                videos[index]['channelName'],
                                                style: TextStyle(
                                                  color: MyStyle().white,
                                                ),
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
          ],
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
}
