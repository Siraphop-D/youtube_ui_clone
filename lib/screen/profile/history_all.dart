import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_ui_clone/components/custom_listtile.dart';
import 'package:youtube_ui_clone/components/video_card.dart';
import 'package:youtube_ui_clone/item/category_item.dart';
import 'package:youtube_ui_clone/responsive/responsive_layout.dart';
import 'package:youtube_ui_clone/screen/search/search_screen.dart';
import 'package:youtube_ui_clone/screen/videoplayer/videoplayer_screen.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class HistoryAll extends StatefulWidget {
  const HistoryAll({super.key});

  @override
  State<HistoryAll> createState() => _HistoryAllState();
}

class _HistoryAllState extends State<HistoryAll> {
  late double screenWidth, screenHeight;
  TextEditingController searchController = TextEditingController();
  bool isTyping = false;
  List<dynamic> videos = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
    searchController.addListener(() {
      setState(() {
        isTyping = searchController.text.isNotEmpty;
      });
    });
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
    return Scaffold(
      backgroundColor: MyStyle().dark,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            ResponsiveLayout.isMobile(context)
                ? buildSliverAppbarMobile(context)
                : buildSliverAppbarTablet(context),
          ];
        },
        body: Expanded(child: buildVideoSection()),
      ),
    );
  }

  SliverAppBar buildSliverAppbarMobile(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: screenHeight * 0.22, // ความสูงตอนกางออก
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
          onPressed: onTabMenu,
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
              titlePadding: EdgeInsets.only(left: 50, bottom: 15, top: 30),
              centerTitle: false,
              title:
                  isCollapsed
                      ? const Text(
                        "History",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : null,

              background: Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.13,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "History",
                        style: TextStyle(
                          fontSize: screenHeight * 0.024,
                          fontWeight: FontWeight.bold,
                          color: MyStyle().white,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      decoration: BoxDecoration(color: MyStyle().grey),

                      duration: Duration(milliseconds: 300),
                      width: screenWidth,
                      height: screenHeight * 0.05,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search),
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              autofocus: false,
                              style: TextStyle(color: MyStyle().white),
                              decoration: InputDecoration(
                                hintText: "Search watch history",
                                hintStyle: TextStyle(
                                  color: MyStyle().lightGrey,
                                  fontSize: screenHeight * 0.016,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          if (isTyping)
                            Container(
                              width: screenWidth * 0.18,
                              height: screenHeight * 0.05,
                              color: MyStyle().lightGrey,
                              child: IconButton(
                                onPressed: searchController.clear,
                                icon: Text("Cancel"),
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
    );
  }

  SliverAppBar buildSliverAppbarTablet(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: screenHeight * 0.22, // ความสูงตอนกางออก
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
          onPressed: onTabMenu,
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
              titlePadding: EdgeInsets.only(left: 50, bottom: 15, top: 20),
              centerTitle: false,
              title:
                  isCollapsed
                      ? const Text(
                        "History",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : null,

              background: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "History",
                        style: TextStyle(
                          fontSize: screenHeight * 0.024,
                          fontWeight: FontWeight.bold,
                          color: MyStyle().white,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      decoration: BoxDecoration(color: MyStyle().grey),

                      duration: Duration(milliseconds: 300),
                      width: screenWidth,
                      height: screenHeight * 0.05,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search),
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              autofocus: false,
                              style: TextStyle(color: MyStyle().white),
                              decoration: InputDecoration(
                                hintText: "Search watch history",
                                hintStyle: TextStyle(
                                  color: MyStyle().lightGrey,
                                  fontSize: screenHeight * 0.016,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          if (isTyping)
                            Container(
                              width: screenWidth * 0.18,
                              height: screenHeight * 0.05,
                              color: MyStyle().lightGrey,
                              child: IconButton(
                                onPressed: searchController.clear,
                                icon: Text("Cancel"),
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
    );
  }

  Widget buildVideoSection() {
    return Expanded(
      child: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return ListTile(
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
            leading: Container(
              width: screenWidth * 0.3,
              height: screenHeight * 0.1,
              child: Image.asset(videos[index]['thumbnail'], fit: BoxFit.cover),
            ),

            title: Text(
              videos[index]['title'],
              style: TextStyle(fontSize: screenHeight * 0.016),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "${videos[index]['channelName']} • ${videos[index]['view']} views",
              style: TextStyle(
                fontSize: screenHeight * 0.014,
                color: MyStyle().lightGrey,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: onTabHistoryItem,
            ),
          );
        },
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

  onTabMenu() {
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
              Column(
                children: List.generate(historymenuItem.length, (index) {
                  return CustomListTile(
                    onTap: () {},
                    leadingIcon: historymenuItem[index]['icon'],
                    title: historymenuItem[index]['title'],
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

  onTabHistoryItem() {
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
              Column(
                children: List.generate(historyItem.length, (index) {
                  return CustomListTile(
                    onTap: () {},
                    leadingIcon: historyItem[index]['icon'],
                    title: historyItem[index]['title'],
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
