import 'package:flutter/material.dart';
import 'package:youtube_ui_clone/components/custom_listtile.dart'
    show CustomListTile;
import 'package:youtube_ui_clone/item/category_item.dart';
import 'package:youtube_ui_clone/screen/search/search_screen.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class MoreInfo extends StatefulWidget {
  final VoidCallback onBack;
  const MoreInfo({super.key, required this.onBack});

  @override
  State<MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  late double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Name "),
        titleSpacing: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: widget.onBack,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "  More info",
                style: TextStyle(
                  fontSize: screenHeight * 0.016,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.008),
            ListTile(
              leading: Icon(Icons.public, color: MyStyle().white),
              title: GestureDetector(
                onTap: () {},
                child: Text(
                  "www.youtube.com/mychannel",
                  style: TextStyle(
                    color: MyStyle().blue,
                    fontSize: screenHeight * 0.016,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info, color: MyStyle().white),
              title: Text(
                "Joined Jun 29, 2015",
                style: TextStyle(fontSize: screenHeight * 0.016),
              ),
            ),
            ListTile(
              leading: Icon(Icons.trending_up, color: MyStyle().white),
              title: Text(
                "36525 views",
                style: TextStyle(fontSize: screenHeight * 0.016),
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
