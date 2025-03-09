import 'package:flutter/material.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late double screenWidth, screenHeight;
  TextEditingController searchController = TextEditingController();
  bool isTyping = false; // checkว่ามีการพิมพ์มั้ย
  List<String> searchRecommend = [
    "มีนาคม",
    "เทพลีลา",
    "theghostradioofficial",
    "ยกกำลัง",
    "GoodDayOfficial",
    "ohana",
    "only monday",
    "โคตรคูล",
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        isTyping = searchController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        titleSpacing: 0,
        title: Expanded(
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: MyStyle().grey,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.all(3),
            duration: Duration(milliseconds: 300),
            width: isTyping ? screenWidth * 0.87 : screenWidth * 0.75,
            height: screenHeight * 0.03,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    autofocus: false,
                    style: TextStyle(color: MyStyle().white),
                    decoration: InputDecoration(
                      hintText: "Search Youtube",
                      hintStyle: TextStyle(
                        color: MyStyle().lightGrey,
                        fontSize: screenHeight * 0.016,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (isTyping)
                  IconButton(
                    onPressed: searchController.clear,
                    icon: Icon(Icons.close),
                  ),
              ],
            ),
          ),
        ),
        actions: [
          if (!isTyping)
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                height: screenHeight * 0.045,
                decoration: BoxDecoration(
                  color: MyStyle().grey,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.mic_outlined, color: MyStyle().white),
                ),
              ),
            ),
        ],
      ),
      body:
          isTyping
              ? Container()
              : Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "You may like",
                        style: TextStyle(fontSize: screenHeight * 0.018),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchRecommend.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.search, color: MyStyle().white),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                searchRecommend[index],
                                style: TextStyle(color: MyStyle().white),
                              ),
                              Transform.rotate(
                                angle: -0.75,
                                child: Icon(Icons.arrow_upward),
                              ),
                            ],
                          ),
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }

  // Widget buildSearchBar() {
  //   return Container(
  //     margin: EdgeInsets.all(5),
  //     width: screenWidth * 0.4,
  //     height: screenHeight * 0.055,
  //     decoration: BoxDecoration(
  //       color: MyStyle().grey,
  //       borderRadius: BorderRadius.circular(25),
  //       border: Border.all(color: Colors.grey[700]!),
  //     ),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Expanded(
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 10),
  //             child: TextField(
  //               controller: searchController,
  //               style: TextStyle(
  //                 color: MyStyle().white,
  //                 fontSize: screenHeight * 0.015,
  //               ),
  //               cursorColor: MyStyle().red,
  //               decoration: InputDecoration(
  //                 hintText: "Search",
  //                 hintStyle: TextStyle(color: Colors.white54),
  //                 border: InputBorder.none,
  //                 contentPadding: EdgeInsets.symmetric(vertical: 10),
  //               ),
  //               onChanged: (value) {
  //                 setState(() {});
  //               },
  //             ),
  //           ),
  //         ),
  //         if (searchController.text.isNotEmpty)
  //           IconButton(
  //             icon: const Icon(Icons.clear, color: Colors.white54, size: 15),
  //             onPressed: () {
  //               searchController.clear();
  //               setState(() {});
  //             },
  //           ),
          // Container(
          //   width: screenWidth * 0.04,
          //   height: screenHeight * 0.055,
          //   decoration: BoxDecoration(
          //     color: Colors.grey[800],
          //     borderRadius: BorderRadius.only(
          //       topRight: Radius.circular(25),
          //       bottomRight: Radius.circular(25),
          //     ),
          //   ),
          //   child: IconButton(
          //     icon: Icon(Icons.search, color: Colors.white),
          //     onPressed: () {},
          //   ),
          // ),
  //       ],
  //     ),
  //   );
  // }
}
