import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youtube_ui_clone/components/drawer_button.dart';
import 'package:youtube_ui_clone/components/navigation_button_desktop.dart';
import 'package:youtube_ui_clone/components/video_card.dart';
import 'package:youtube_ui_clone/item/category_item.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  late double screenWidth, screenHeight;
  final TextEditingController searchController = TextEditingController();
  int categoryIndex = 0;
  bool isExpanded = false;
  int tabIndex = 0;
  onChangeTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  List<dynamic> videoList = [];

  @override
  void initState() {
    super.initState();
    loadVideos();
  }

  Future<void> loadVideos() async {
    String data = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/json/video.json');
    setState(() {
      videoList = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded; // กดแล้วเปลี่ยนขนาด
                });
              },
              icon: Icon(Icons.menu),
            ),
            SizedBox(width: screenWidth * 0.01),
            SvgPicture.asset(
              "assets/icons/logo.svg",
              height: screenHeight * 0.028,
            ),
            Spacer(),
            buildSearchBar(),
            SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.mic, color: Colors.white),
            ),
            Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {},
              child: Container(
                height: screenHeight * 0.04,
                width: screenWidth * 0.056,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: MyStyle().grey,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text(
                      "Create",
                      style: TextStyle(fontSize: screenHeight * 0.016),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.01),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
            SizedBox(width: screenWidth * 0.01),
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage("assets/icons/profile.png"),
              ),
            ),
          ],
        ),
        backgroundColor: MyStyle().dark,
      ),
      body: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width:
                isExpanded
                    ? screenWidth * 0.17
                    : screenWidth * 0.045, // ปรับขนาด
            color: MyStyle().dark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [buildExpanded()],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width:
                isExpanded
                    ? screenWidth * 0.826
                    : screenWidth * 0.953, // ปรับขนาด

            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = isExpanded ? 3 : 4;
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: screenHeight * 0.35,
                      childAspectRatio: 16 / 9,
                    ),
                    itemCount: videoList.length,
                    itemBuilder: (context, index) {
                      var video = videoList[index];
                      return InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: screenHeight * 0.2,
                              width: screenWidth * 0.25,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/icons/youtube_kid.svg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.all(
                                MyStyle().defaultSPadding,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      video['channelProfileUrl'],
                                    ),
                                  ),
                                  SizedBox(width: MyStyle().defaultSPadding),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          video['title'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(height: 1.5),
                                        ),
                                        SizedBox(
                                          height: MyStyle().defaultXSPadding,
                                        ),
                                        Text(
                                          video['channelName'],
                                          style: MyStyle().smallStyle.copyWith(
                                            color: MyStyle().lightGrey,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              video['view'],
                                              style: MyStyle().smallStyle
                                                  .copyWith(
                                                    color: MyStyle().lightGrey,
                                                  ),
                                            ),
                                            Text(
                                              " • ",
                                              style: MyStyle().smallStyle
                                                  .copyWith(
                                                    color: MyStyle().lightGrey,
                                                  ),
                                            ),
                                            Text(
                                              video['dateTime'],
                                              style: MyStyle().smallStyle
                                                  .copyWith(
                                                    color: MyStyle().lightGrey,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: MyStyle().defaultSPadding),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      LineIcons.verticalEllipsis,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildVideoSection() {
  //   return Column(
  //     children: List.generate(videos.length, (index) {
  //       return VideoCard(
  //         onTap: () {},
  //         // => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage())),
  //         videoUrl: videos[index]['videoUrl'],
  //         duration: videos[index]['duration'],
  //         title: videos[index]['title'],
  //         channelProfileUrl: videos[index]['channelProfileUrl'],
  //         channelName: videos[index]['channelName'],
  //         view: videos[index]['view'],
  //         dateTime: videos[index]['dateTime'],
  //       );
  //     }),
  //   );
  // }

  Widget buildExpanded() {
    return isExpanded
        ? Navigation_button()
        : Expanded(
          flex: 2,
          child: ListView(
            children: [
              NavigationButtonDesktop(
                onTap: () => onChangeTab(0),
                isActive: tabIndex == 0,
                isExpanded: true,
                alignment: Alignment.centerLeft,
                activeIcon: SvgPicture.asset(
                  "assets/icons/home_active.svg",
                  color: MyStyle().white,
                ),
                inactiveIcon: SvgPicture.asset(
                  "assets/icons/home.svg",
                  color: MyStyle().white,
                ),
                text: "Home",
              ),
              NavigationButtonDesktop(
                onTap: () => onChangeTab(1),
                isActive: tabIndex == 1,
                isExpanded: true,

                activeIcon: SvgPicture.asset(
                  "assets/icons/short_active.svg",
                  color: MyStyle().white,
                ),
                inactiveIcon: SvgPicture.asset(
                  "assets/icons/short.svg",
                  color: MyStyle().white,
                ),
                text: "Short",
              ),
              NavigationButtonDesktop(
                onTap: () => onChangeTab(2),
                isActive: tabIndex == 2,
                isExpanded: true,
                alignment: Alignment.centerRight,
                activeIcon: SvgPicture.asset(
                  "assets/icons/subscription_active.svg",
                  color: MyStyle().white,
                ),
                inactiveIcon: SvgPicture.asset(
                  "assets/icons/subscription.svg",
                  color: MyStyle().white,
                ),
                text: "Sub",
              ),
              NavigationButtonDesktop(
                onTap: () => onChangeTab(3),
                isActive: tabIndex == 3,
                isExpanded: true,
                activeIcon: SvgPicture.asset(
                  "assets/icons/library_active.svg",
                  color: MyStyle().white,
                ),
                inactiveIcon: SvgPicture.asset(
                  "assets/icons/library.svg",
                  color: MyStyle().white,
                ),
                text: "Library",
              ),
            ],
          ),
        );
  }

  Widget buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(5),
      width: screenWidth * 0.4,
      height: screenHeight * 0.055,
      decoration: BoxDecoration(
        color: MyStyle().grey,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: searchController,
                style: TextStyle(
                  color: MyStyle().white,
                  fontSize: screenHeight * 0.015,
                ),
                cursorColor: MyStyle().red,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                  ), // ✅ ปรับ padding ให้อยู่กลาง
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
          if (searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.white54, size: 15),
              onPressed: () {
                searchController.clear();
                setState(() {});
              },
            ),
          Container(
            width: screenWidth * 0.04,
            height: screenHeight * 0.055,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
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
}
