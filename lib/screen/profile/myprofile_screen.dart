import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_ui_clone/components/custom_listtile.dart';
import 'package:youtube_ui_clone/item/category_item.dart';
import 'package:youtube_ui_clone/responsive/responsive_layout.dart';
import 'package:youtube_ui_clone/screen/notification/notification_screen.dart';
import 'package:youtube_ui_clone/screen/search/search_screen.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class MyprofileScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyprofileScreen({super.key, required this.navigatorKey});

  @override
  State<MyprofileScreen> createState() => _MyprofileScreenState();
}

class _MyprofileScreenState extends State<MyprofileScreen>
    with SingleTickerProviderStateMixin {
  late double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4, // จำนวนแท็บ
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
              _buildHomeTab(),
              _buildVideosTab(),
              Center(
                child: Text("Playlists", style: TextStyle(color: Colors.white)),
              ),
              Center(
                child: Text("Posts", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppBarTablet(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: screenHeight * 0.3, // ความสูงตอนกางออก
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
                        "Siraphop D",
                        style: TextStyle(color: Colors.white),
                      )
                      : null,

              background: Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.07,
                  left: screenHeight * 0.013,
                  right: screenHeight * 0.013,
                ),
                child: buildProfile(widget.navigatorKey),
              ),
            ),
          );
        },
      ),
      bottom: const TabBar(
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        tabs: [
          Tab(text: "Home"),
          Tab(text: "Videos"),
          Tab(text: "Playlists"),
          Tab(text: "Posts"),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBarMobile(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: screenHeight * 0.33, // ความสูงตอนกางออก
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
              titlePadding: const EdgeInsets.only(left: 50, bottom: 62),
              centerTitle: false,
              title:
                  isCollapsed
                      ? const Text(
                        "Siraphop D",
                        style: TextStyle(color: Colors.white),
                      )
                      : null,

              background: Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.13,
                  left: screenHeight * 0.013,
                  right: screenHeight * 0.013,
                ),
                child: buildProfile(widget.navigatorKey),
              ),
            ),
          );
        },
      ),
      bottom: const TabBar(
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        tabs: [
          Tab(text: "Home"),
          Tab(text: "Videos"),
          Tab(text: "Playlists"),
          Tab(text: "Posts"),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Column(
        children: [const SizedBox(height: 10), _buildVideoSection()],
      ),
    );
  }

  Widget _buildVideosTab() {
    return _buildVideoSection();
  }

  Widget _buildVideoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            "Videos",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Image.network(
                  "https://i.ytimg.com/vi/your_video_thumbnail.jpg", // เปลี่ยนเป็น URL รูปจริง
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "นาฏยศัพท์ประกอบเพลง รากไทย ของนักเรียนชั้นมัธยมศึกษา...",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildProfile(GlobalKey<NavigatorState> navigatorKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                    fontSize: screenHeight * 0.016,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '@profilename',
                  style: TextStyle(
                    color: MyStyle().white,
                    fontSize: screenHeight * 0.015,
                  ),
                ),
                Text(
                  "72 subscribers • 1 video",
                  style: TextStyle(
                    color: MyStyle().white,
                    fontSize: screenHeight * 0.015,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Text(
                  "More about this channel",
                  style: TextStyle(
                    color: MyStyle().white,
                    fontSize: screenHeight * 0.016,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    navigatorKey.currentState!.pushNamed('/moreinfo');
                  },
                  child: Text(
                    "...more",
                    style: TextStyle(
                      color: MyStyle().white,
                      fontSize: screenHeight * 0.016,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},

              style: ElevatedButton.styleFrom(
                backgroundColor: MyStyle().grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                fixedSize: ResponsiveLayout.isMobile(context)? Size.fromWidth(screenWidth * 0.65):Size.fromWidth(screenWidth * 0.8),
                
              ),
              child: Text(
                "Manage videos",
                style: TextStyle(
                  color: MyStyle().white,
                  fontSize: screenHeight * 0.016,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.015),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: MyStyle().grey,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.bar_chart_rounded, size: screenHeight * 0.03),
              ),
            ),
            SizedBox(width: screenWidth * 0.015),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: MyStyle().grey,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, size: screenHeight * 0.03),
              ),
            ),
          ],
        ),
      ],
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
