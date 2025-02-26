import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortsVideoPlayer extends StatefulWidget {
  final String title,
      description,
      channelProfileUrl,
      channel,
      upload_date,
      duration,
      views,
      likes,
      comments,
      video_url,
      tags;

  const ShortsVideoPlayer({
    Key? key,
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
  }) : super(key: key);

  @override
  _ShortsVideoPlayerState createState() => _ShortsVideoPlayerState();
}

class _ShortsVideoPlayerState extends State<ShortsVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video_url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // เล่นอัตโนมัติ
        _controller.setLooping(true); // วนซ้ำ
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 📹 Video Player
        _controller.value.isInitialized
            ? VideoPlayer(_controller)
            : Center(child: CircularProgressIndicator(color: Colors.white)),

        // 🔘 UI Controls (ปุ่ม Like, Comment, Share)
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.white, size: 40),
                onPressed: () {},
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

        // 📝 Video Description
        Positioned(
          bottom: 30,
          left: 16,
          right: 10,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.channelProfileUrl),
                radius: 24,
              ),
              SizedBox(width: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.channel,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.title,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
