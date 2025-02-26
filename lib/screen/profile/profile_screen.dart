import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_ui_clone/components/custom_listtile.dart';
import 'package:youtube_ui_clone/item/category_item.dart';
import 'package:youtube_ui_clone/screen/notification/notification_screen.dart';
import 'package:youtube_ui_clone/screen/search/search_screen.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onNavigate;
  const ProfileScreen({Key? key, required this.onNavigate}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late double screenWidth, screenHeight;
  int profileIndex = 0;
  int settindIndex = 0;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
              child: buildProfile(),
            ),
            buildCategory(),
            buildHistory(),
            buildPlaylist(),
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

  buildHistory() {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              "History",
              style: TextStyle(
                fontSize: screenHeight * 0.019,
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
        Container(
          width: screenWidth,
          height: screenHeight * 0.15,
          color: MyStyle().grey,
        ),
      ],
    );
  }

  buildPlaylist() {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              "Playlists",
              style: TextStyle(
                fontSize: screenHeight * 0.019,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.add)),
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
        Container(
          width: screenWidth,
          height: screenHeight * 0.15,
          color: MyStyle().grey,
        ),
      ],
    );
  }

  buildMenuItem(IconData icon, String title, {Color iconColor = Colors.white}) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: screenHeight * 0.03),
      title: Text(
        title,
        style: TextStyle(fontSize: screenHeight * 0.018, color: iconColor),
      ),
    );
  }

  buildProfile() {
    return InkWell(
      onTap: widget.onNavigate,
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
                  fontSize: screenHeight * 0.02,
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
                          fontSize: screenHeight*0.014,
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
          heightFactor: 0.98, // จำกัดความสูง
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: MyStyle().defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MyStyle().defaultSPadding),

                // Header (ปุ่ม Close + ชื่อ "Settings")
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

                // ใช้ Expanded + ListView.separated แทน Column
                Expanded(
                  child: ListView.separated(
                    itemCount: settingsItems.length,
                    separatorBuilder: (context, index) {
                      // เงื่อนไขเพิ่มข้อความคั่น (กรณีเพิ่มหมวดหมู่)

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
                                "Video and audio preferrences", // ข้อความหัวข้อคั่น
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
                                "Help and policies", // ข้อความหัวข้อคั่น
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
                        onTap: () {},
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
