import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_ui_clone/components/shortvideo_player.dart';

class ShortScreen extends StatefulWidget {
  const ShortScreen({Key? key}) : super(key: key);

  @override
  State<ShortScreen> createState() => _ShortScreenState();
}

class _ShortScreenState extends State<ShortScreen> {
  List<dynamic> shorts = [];
  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      String jsonString = await rootBundle.loadString('assets/json/short.json');
      List<dynamic> jsonData = jsonDecode(jsonString);

      setState(() {
        shorts = List<Map<String, dynamic>>.from(jsonData);
      });

      print("✅ Shorts Loaded Successfully: ${shorts.length} items");
    } catch (e) {
      print("❌ Error loading JSON: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(child: Text("Short Page")),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   expandedHeight: 50.0,
          //   automaticallyImplyLeading: false,

          //   title: SvgPicture.asset("assets/icons/logo.svg"),
          //   actions: [
          //     IconButton(
          //       onPressed: () {},
          //       splashRadius: 25,
          //       icon: Icon(Icons.cast),
          //     ),
          //     IconButton(
          //       onPressed: () {},
          //       splashRadius: 25,
          //       icon: Icon(Icons.notifications_outlined),
          //     ),
          //     IconButton(
          //       onPressed: () {},
          //       splashRadius: 25,
          //       icon: Icon(Icons.search),
          //     ),
          //   ],
          // ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: shorts.length,
                itemBuilder: (context, index) {
                  if (index >= shorts.length)
                    return Center(child: Text("No data"));

                  var shortItem = shorts[index] as Map<String, dynamic>;

                  return ShortsVideoPlayer(
                    title: shortItem['title'] ?? 'No Title',
                    description: shortItem['description'] ?? '',
                    channelProfileUrl: shortItem['channelProfileUrl'] ?? '',
                    channel: shortItem['channel'] ?? '',
                    upload_date: shortItem['upload_date'] ?? '',
                    duration: shortItem['duration'] ?? '',
                    views: shortItem['views'] ?? '0',
                    likes: shortItem['likes'] ?? '-',
                    comments: shortItem['comments'] ?? 'No Comment',
                    video_url: shortItem['video_url'] ?? '',
                    tags: (shortItem['tags'] as List?)?.join(', ') ?? '',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
