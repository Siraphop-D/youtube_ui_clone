import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_ui_clone/components/video_card.dart';
import 'package:youtube_ui_clone/responsive/responsive_layout.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl, duration, title, thumbnail;
  final String channelProfile, channelName, view, dateTime;
  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.duration,
    required this.title,
    required this.thumbnail,
    required this.channelProfile,
    required this.channelName,
    required this.view,
    required this.dateTime,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  late double screenWidth, screenHeight;
  late String? videoId;
  List<dynamic> videos = [];
  late bool isPortrait;
  late bool isAutoPlayEnabled;

  @override
  void initState() {
    super.initState();
    loadJsonData();
    videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    isAutoPlayEnabled = true; // เริ่มต้นเป็นเล่นอัตโนมัติ

    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: YoutubePlayerFlags(
          autoPlay: isAutoPlayEnabled,
          enableCaption: true,
          isLive: false,
          forceHD: true,
        ),
      )..setFullScreenListener((isFullScreen) {
          if (isFullScreen) {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          } else {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          }
        });
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller.dispose();
    super.dispose();
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

    return Scaffold(
      body: SafeArea(
        child: videoId == null
            ? Center(
                child: Text(
                  "ไม่สามารถโหลดวิดีโอได้",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YoutubePlayer(
                          
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          progressColors: ProgressBarColors(
                            playedColor: MyStyle().red,
                            handleColor: MyStyle().red,
                          ),
                          bottomActions: [
                            CurrentPosition(),
                            ProgressBar(
                              isExpanded: true,
                              colors: ProgressBarColors(
                                playedColor: MyStyle().red,
                                handleColor: MyStyle().red,
                              ),
                            ),
                            PlaybackSpeedButton(),
                            FullScreenButton(),
                          ],
                         
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.title}",
                                style: TextStyle(color: MyStyle().white, fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${widget.view} views • ${widget.dateTime}",
                                style: TextStyle(color: MyStyle().lightGrey, fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildActionButton(Icons.thumb_up, "Like"),
                                  _buildActionButton(Icons.share, "Share"),
                                  _buildActionButton(Icons.repeat, "Remix"),
                                  _buildActionButton(Icons.attach_money, "Thanks"),
                                ],
                              ),
                              Divider(color: Colors.grey),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(widget.channelProfile),
                                    radius: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    widget.channelName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Subscribe",
                                      style: TextStyle(color: MyStyle().black),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyStyle().white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(color: Colors.grey),
                              Text(
                                "Comments 150",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              _buildComment(
                                avatar: "assets/channelprofile/13.png",
                                username: "@user123",
                                comment: "🩷💚",
                              ),
                              buildVideoSection(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                 
                ],
              ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildComment({required String avatar, required String username, required String comment}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundImage: AssetImage(avatar), radius: 20),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(comment, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVideoSection() {
    return ResponsiveLayout.isMobile(context)
        ? Column(
            children: List.generate(videos.length, (index) {
              return VideoCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(
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
                videoUrl: videos[index]['videoUrl'],
                duration: videos[index]['duration'],
                title: videos[index]['title'],
                channelProfile: videos[index]['channelProfile'],
                channelName: videos[index]['channelName'],
                view: videos[index]['view'],
                dateTime: videos[index]['dateTime'],
                thumbnail: videos[index]['thumbnail'],
              );
            }),
          )
        : LayoutBuilder(
            builder: (context, constrains) {
              int crossAxisCount = isPortrait ? 2 : 3;
              return Padding(
                padding: EdgeInsets.all(8),
                child: videos.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 20,
                            mainAxisExtent: constrains.maxWidth > 900
                                ? isPortrait
                                    ? screenHeight * 0.24
                                    : screenHeight * 0.41
                                : screenHeight * 0.3,
                            childAspectRatio: 16 / 9,
                          ),
                          itemCount: videos.length,
                          itemBuilder: (context, index) {
                            return VideoCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayerScreen(
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
                              videoUrl: videos[index]['videoUrl'],
                              duration: videos[index]['duration'],
                              title: videos[index]['title'],
                              channelProfile: videos[index]['channelProfile'],
                              channelName: videos[index]['channelName'],
                              view: videos[index]['view'],
                              dateTime: videos[index]['dateTime'],
                              thumbnail: videos[index]['thumbnail'],
                            );
                          },
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
              );
            },
          );
  }

}
extension on YoutubePlayerController {
  void toggleAutoplay() {}
  
  setFullScreenListener(Null Function(dynamic isFullScreen) param0) {}
}
