import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShortsVideoPlayer extends StatefulWidget {
  final String title;
  final String description;
  final String channelProfileUrl;
  final String channel;
  final String upload_date;
  final String duration;
  final String views;
  final String likes;
  final String comments;
  final String video_url;
  final String tags;

  ShortsVideoPlayer({
    required this.title,
    required this.description,
    required this.channelProfileUrl,
    required this.channel,
    required this.upload_date,
    required this.duration,
    required this.views,
    required this.likes,
    required this.comments,
    required this.video_url,
    required this.tags,
  });

  @override
  _ShortsVideoPlayerState createState() => _ShortsVideoPlayerState();
}

class _ShortsVideoPlayerState extends State<ShortsVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.video_url);

    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        loop: true,
        mute: false,
        forceHD: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              onReady: () {
                print("!!!!Player Ready");
              },
            ),
          ),
          Positioned(
            right: 16,
            bottom: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.white, size: 40),
                  onPressed: () {
                    setState(() {
                      Icon(Icons.favorite, color: MyStyle().red, size: 40);
                    });
                  },
                ),
                Text(widget.views, style: TextStyle(color: Colors.white)),
                SizedBox(height: 20),
                IconButton(
                  icon: Icon(Icons.comment, color: Colors.white, size: 40),
                  onPressed: () {},
                ),
                Text(widget.comments, style: TextStyle(color: Colors.white)),
                SizedBox(height: 20),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.white, size: 40),
                  onPressed: () {},
                ),
                Text("Share", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 5,
            right: 20,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.channelProfileUrl),
                  radius: 24,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        widget.channel,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Row(
                        children: [
                          Text(
                            "${widget.views} views",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "${widget.likes} likes",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// class ShortsVideoPlayer extends StatefulWidget {
//   final String title,
//       description,
//       channelProfileUrl,
//       channel,
//       upload_date,
//       duration,
//       views,
//       likes,
//       comments,
//       video_url,
//       tags;

//   const ShortsVideoPlayer({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.channelProfileUrl,
//     required this.channel,
//     required this.upload_date,
//     required this.duration,
//     required this.views,
//     required this.likes,
//     required this.comments,
//     required this.video_url,
//     required this.tags,
//   }) : super(key: key);

//   @override
//   _ShortsVideoPlayerState createState() => _ShortsVideoPlayerState();
// }

// class _ShortsVideoPlayerState extends State<ShortsVideoPlayer> {
//   late YoutubePlayerController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = YoutubePlayerController(
//       initialVideoId: widget.video_url,
//       flags: YoutubePlayerFlags(autoPlay: true, mute: false),
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // 📹 Video Player
//         controller.value.isReady
//             ? YoutubePlayer(controller: controller,showVideoProgressIndicator: true,)
//             : Center(child: CircularProgressIndicator(color: Colors.white)),

//         // 🔘 UI Controls (ปุ่ม Like, Comment, Share)
        // Positioned(
        //   right: 16,
        //   bottom: 170,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       IconButton(
        //         icon: Icon(Icons.favorite, color: Colors.white, size: 40),
        //         onPressed: () {
        //           setState(() {
        //             Icon(Icons.favorite, color: MyStyle().red, size: 40);
        //           });
        //         },
        //       ),
        //       Text(widget.views, style: TextStyle(color: Colors.white)),
        //       SizedBox(height: 20),
        //       IconButton(
        //         icon: Icon(Icons.comment, color: Colors.white, size: 40),
        //         onPressed: () {},
        //       ),
        //       Text(widget.comments, style: TextStyle(color: Colors.white)),
        //       SizedBox(height: 20),
        //       IconButton(
        //         icon: Icon(Icons.share, color: Colors.white, size: 40),
        //         onPressed: () {},
        //       ),
        //       Text("Share", style: TextStyle(color: Colors.white)),
        //     ],
        //   ),
        // ),

//         // 📝 Video Description
//         Positioned(
//           bottom: 120,
//           left: 16,
//           right: 10,
//           child: Row(
//             children: [
              // CircleAvatar(
              //   backgroundImage: NetworkImage(widget.channelProfileUrl),
              //   radius: 24,
              // ),
              // SizedBox(width: 10),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.channel,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       widget.title,
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                       maxLines: 2,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
