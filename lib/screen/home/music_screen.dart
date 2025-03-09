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

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  late double screenWidth, screenHeight;
  List<dynamic> videos = [];
  String selectedTab = "Home";
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

  String getTabName(int index) {
    switch (index) {
      case 1:
        return "Posts";
      default:
        return "Home";
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return DefaultTabController(
      length: 2,
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
            children: [buildVideoSection(), buildVideoSection()],
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
              ? screenHeight * 0.07
              : screenHeight * 0.1, // ความสูงตอนกางออก
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
              titlePadding: EdgeInsets.only(left: 50, bottom: 62),
              centerTitle: false,
              title:
                  isCollapsed
                      ? Text(selectedTab, style: TextStyle(color: Colors.white))
                      : null,
            ),
          );
        },
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedTab = getTabName(index);
          });
        },
        tabs: [Tab(text: "Home"), Tab(text: "Posts")],
      ),
    );
  }

  SliverAppBar buildSliverAppBarMobile(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: screenHeight * 0.1, // ความสูงตอนกางออก
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
          bool isCollapsed = appBarHeight <= 170;

          return Container(
            decoration: BoxDecoration(color: MyStyle().dark),
            child: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 50, bottom: 62),
              centerTitle: false,
              title:
                  isCollapsed
                      ? Text(selectedTab, style: TextStyle(color: Colors.white))
                      : null,
            ),
          );
        },
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedTab = getTabName(index);
          });
        },
        tabs: [Tab(text: "Home"), Tab(text: "Posts")],
      ),
    );
  }

  Widget buildMainVideo() {
    return CarouselSlider.builder(
      itemCount: videos.length,
      options: CarouselOptions(
        height: screenHeight * 0.4,
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
                      backgroundImage: AssetImage("assets/icons/m_sic.jpg"),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Music",
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

  Widget buildVideoSection() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            buildMainVideo(),
            buildCategorySection(),
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
                        child: Column(
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
                              trailing: IconButton(
                                onPressed: onTabMore,
                                icon: Icon(Icons.more_vert),
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
