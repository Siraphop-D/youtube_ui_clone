import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:youtube_ui_clone/components/custom_listtile.dart';
import 'package:youtube_ui_clone/components/drawer_button.dart';
import 'package:youtube_ui_clone/components/navigation_button.dart';
import 'package:youtube_ui_clone/components/navigation_button_desktop.dart';
import 'package:youtube_ui_clone/item/create_item.dart';
import 'package:youtube_ui_clone/responsive/desktop_scaffold.dart';
import 'package:youtube_ui_clone/responsive/responsive_layout.dart';
import 'package:youtube_ui_clone/screen/home/home_page.dart';
import 'package:youtube_ui_clone/screen/profile/more_info.dart';
import 'package:youtube_ui_clone/screen/profile/myprofile_screen.dart';
import 'package:youtube_ui_clone/screen/profile/profile_screen.dart';
import 'package:youtube_ui_clone/screen/short/short_screen.dart';
import 'package:youtube_ui_clone/screen/subscription/subscription_all.dart';
import 'package:youtube_ui_clone/screen/subscription/subscription_screen.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class NaviScreen extends StatefulWidget {
  const NaviScreen({super.key});
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  @override
  State<NaviScreen> createState() => _NaviScreenState();
}

class _NaviScreenState extends State<NaviScreen> {
  int tabIndex = 0;
  bool isExpanded = false;
  bool isAllSubscriptions = false;
  bool isMyProfile = false;
  bool isMoreInfo = false;
  late double screenWidth, screenHeight;
  onChangeTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: NaviScreen.scaffoldKey,
      body: buildBody(),
      bottomNavigationBar: buildNavigationBar(),
      // ResponsiveLayout.isDesktop(context)
      //     ? buildNavigationBar()
      //     : const SizedBox.shrink(),
      drawer: showDrawer(),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      centerTitle: false,
      title: SvgPicture.asset("assets/icons/logo.svg"),
      backgroundColor: MyStyle().dark,
      actions: [
        IconButton(onPressed: () {}, splashRadius: 25, icon: Icon(Icons.cast)),
        IconButton(
          onPressed: () {},
          splashRadius: 25,
          icon: Icon(Icons.notifications_outlined),
        ),
        IconButton(
          onPressed: () {},
          splashRadius: 25,
          icon: Icon(Icons.search),
        ),
      ],
    );
  }

  IndexedStack buildBody() {
    return IndexedStack(
      index: tabIndex,
      children: [
        HomePage(),
        ShortScreen(),
        isAllSubscriptions
            ? SubscriptionAll(
              onBack: () {
                setState(() {
                  isAllSubscriptions = false;
                });
              },
            )
            : SubscriptionScreen(
              onNavigate: () {
                setState(() {
                  isAllSubscriptions = true;
                });
              },
            ),

        isMyProfile
            ? MyprofileScreen(
              onBack:
                  () => setState(() {
                    isMyProfile = false;
                    isMoreInfo = false;
                  }),
              onNavigate:
                  () => setState(() {
                    isMoreInfo = true;
                    isMyProfile = false;
                  }),
            )
            : isMoreInfo
            ? MoreInfo(
              onBack:
                  () => setState(() {
                    isMyProfile = true;
                  }),
            )
            : ProfileScreen(
              onNavigate: () {
                setState(() {
                  isMyProfile = true;
                });
              },
            ),
      ],
    );
  }

  Widget buildNavigationBar() {
    return ResponsiveLayout.isMobile(context)
        ? LayoutBuilder(
          builder: (context, constraints) {
            double screenHeight = constraints.maxHeight;
            double screenWidth = constraints.maxWidth;
            double buttonSize = screenHeight * 0.025; // ปรับขนาดปุ่มตามหน้าจอ

            return Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              height: screenHeight * 0.1, // ความสูงของ NavigationBar
              decoration: BoxDecoration(
                color: MyStyle().dark,
                border: Border(
                  top: BorderSide(width: 1.5, color: MyStyle().grey),
                ),
                boxShadow: [
                  BoxShadow(
                    color: MyStyle().grey,
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // ให้ปุ่มห่างกันเท่ากัน
                  children: [
                    Expanded(
                      child: buildNavItem(
                        onTap: () => onChangeTab(0),
                        isActive: tabIndex == 0,
                        activeIconPath: "assets/icons/home_active.svg",
                        inactiveIconPath: "assets/icons/home.svg",
                        text: "Home",
                        iconSize: buttonSize,
                      ),
                    ),
                    Expanded(
                      child: buildNavItem(
                        onTap: () => onChangeTab(1),
                        isActive: tabIndex == 1,
                        activeIconPath: "assets/icons/short_active.svg",
                        inactiveIconPath: "assets/icons/short.svg",
                        text: "Short",
                        iconSize: buttonSize,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: onTabCreate,
                        iconSize:
                            buttonSize * 1.4, // ปรับขนาดให้ปุ่ม + ใหญ่ขึ้น
                        icon: SvgPicture.asset(
                          "assets/icons/add.svg",
                          color: MyStyle().white,
                          height: buttonSize * 1.4,
                        ),
                      ),
                    ),
                    Expanded(
                      child: buildNavItem(
                        onTap: () => onChangeTab(2),
                        isActive: tabIndex == 2,
                        activeIconPath: "assets/icons/subscription_active.svg",
                        inactiveIconPath: "assets/icons/subscription.svg",
                        text: "Sub",
                        iconSize: buttonSize,
                      ),
                    ),
                    Expanded(
                      child: buildNavItem(
                        onTap: () => onChangeTab(3),
                        isActive: tabIndex == 3,
                        activeIconPath: "assets/icons/profile_active.svg",
                        inactiveIconPath: "assets/icons/profile.svg",
                        text: "You",
                        iconSize: buttonSize,
                        isProfile: true, // ใช้ CircleAvatar แทน
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
        : buildTabletNavigationBar();
  }

  Widget buildTabletNavigationBar() {
    return ResponsiveLayout.isTablet(context)
        ? Container(
          padding: EdgeInsets.only(
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
          ),
          height: screenHeight * 0.0839,
          decoration: BoxDecoration(
            color: MyStyle().dark,
            border: Border(top: BorderSide(width: 1.5, color: MyStyle().grey)),
            boxShadow: [
              BoxShadow(color: MyStyle().grey, blurRadius: 2, spreadRadius: 1),
            ],
          ),
          child: Scaffold(
            body: Container(
              margin: EdgeInsets.only(
                top: screenHeight * 0.009,
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: NavigationButton(
                      onTap: () => onChangeTab(0),
                      isActive: tabIndex == 0,
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
                  ),
                  Expanded(
                    flex: 3,
                    child: NavigationButton(
                      onTap: () => onChangeTab(1),
                      isActive: tabIndex == 1,
                      // alignment: Alignment.centerLeft,
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
                  ),
                  Expanded(
                    flex: 3,
                    child: IconButton(
                      onPressed: onTabCreate,
                      padding: EdgeInsets.all(2),
                      icon: SvgPicture.asset(
                        "assets/icons/add.svg",
                        color: MyStyle().white,
                        height: 40,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: NavigationButton(
                      onTap: () => onChangeTab(2),
                      isActive: tabIndex == 2,
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
                  ),
                  Expanded(
                    flex: 3,
                    child: NavigationButton(
                      onTap: () => onChangeTab(3),
                      isActive: tabIndex == 3,
                      // alignment: Alignment.centerRight,
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
                  ),
                ],
              ),
            ),
          ),
        )
        : DesktopScaffold();
  }

  Widget buildDesktopNavigationBar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: isExpanded ? screenWidth * 0.17 : screenWidth * 0.045, // ปรับขนาด
      color: MyStyle().dark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildExpanded()],
      ),
    );
  }

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

  onTabCreate() {
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
                    Text("Create", style: MyStyle().titleStyle),
                    Icon(Icons.close),
                  ],
                ),
              ),
              SizedBox(height: MyStyle().defaultSPadding),
              Column(
                children: List.generate(createItems.length, (index) {
                  return CustomListTile(
                    onTap: () {},
                    leadingIcon: createItems[index]['icon'],
                    title: createItems[index]['title'],
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

  Drawer showDrawer() => Drawer(
    backgroundColor: MyStyle().grey,
    child: ListView(
      children: [
        // DrawerHeader(
        //   // decoration: BoxDecoration(color: Colors.blue),
        //   child: SvgPicture.asset("assets/icons/logo.svg"),
        // ),
        ListTile(
          title: Row(children: [SvgPicture.asset("assets/icons/logo.svg")]),

          onTap: () {
            Navigator.pop(context);
          },
        ),

        ListTile(
          title: Row(
            children: [
              Image.asset("assets/icons/fire.png"),
              SizedBox(width: 10),
              Text('Trending'),
            ],
          ),

          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset("assets/icons/music.png"),
              SizedBox(width: 10),
              Text('Music'),
            ],
          ),

          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset("assets/icons/game-console.png"),
              SizedBox(width: 10),
              Text('Gaming'),
            ],
          ),

          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset("assets/icons/journal.png"),
              SizedBox(width: 10),
              Text('News'),
            ],
          ),

          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset("assets/icons/trophy.png"),
              SizedBox(width: 10),
              Text('Sports'),
            ],
          ),

          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(thickness: 1, color: MyStyle().white),
        ListTile(
          title: Row(
            children: [
              SvgPicture.asset("assets/icons/youtube_studio.svg"),
              SizedBox(width: 10),
              Text('Youtube Studio'),
            ],
          ),

          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              SvgPicture.asset("assets/icons/youtube_music.svg"),
              SizedBox(width: 10),
              Text('Youtube Music'),
            ],
          ),

          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              SvgPicture.asset("assets/icons/youtube_kid.svg"),
              SizedBox(width: 10),
              Text('Youtube Kids'),
            ],
          ),

          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );

  Widget buildNavItem({
    required VoidCallback onTap,
    required bool isActive,
    required String activeIconPath,
    required String inactiveIconPath,
    required String text,
    required double iconSize,
    bool isProfile = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // จัดให้อยู่ตรงกลาง
        children: [
          isProfile
              ? Container(
                padding: EdgeInsets.all(isActive ? 3 : 0), // กำหนดขนาดกรอบ
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      isActive
                          ? Border.all(
                            color: Colors.white,
                            width: 1,
                          ) // กรอบสีขาว
                          : null, // ไม่มีกรอบถ้าไม่ active
                ),
                child: CircleAvatar(
                  radius: iconSize * 0.5,
                  backgroundImage: AssetImage("assets/icons/profile.png"),
                ),
              )
              : SvgPicture.asset(
                isActive ? activeIconPath : inactiveIconPath,
                color: MyStyle().white,
                height: iconSize,
              ),
          SizedBox(height: 4), // ปรับระยะห่างระหว่างไอคอนกับข้อความ
          Text(
            text,
            style: TextStyle(
              fontSize: iconSize * 0.4, // ปรับขนาดฟอนต์สัมพันธ์กับขนาดไอคอน
              color: MyStyle().white,
            ),
          ),
        ],
      ),
    );
  }
}
