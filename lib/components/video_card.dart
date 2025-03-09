import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class VideoCard extends StatelessWidget {
  final String videoUrl, duration, title, thumbnail;
  final String channelProfile, channelName, view, dateTime;
  final VoidCallback onTap;

  const VideoCard({
    Key? key,
    required this.videoUrl,
    required this.duration,
    required this.title,
    required this.channelProfile,
    required this.channelName,
    required this.view,
    required this.dateTime,
    required this.onTap,
    required this.thumbnail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return buildTabletCard(); // Tablet
        } else {
          return buildMobileCard(); // Mobile
        }
      },
    );
  }

  Widget buildMobileCard() {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: MyStyle().defaultSPadding,
                right: MyStyle().defaultSPadding,
                child: Container(
                  padding: EdgeInsets.all(MyStyle().defaultXSPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      MyStyle().defaultRadius / 4,
                    ),
                    color: MyStyle().black.withOpacity(0.8),
                  ),
                  child: Text(
                    duration,
                    style: MyStyle().smallStyle.copyWith(
                      color: MyStyle().white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(MyStyle().defaultSPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(channelProfile),
                ),
                SizedBox(width: MyStyle().defaultSPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(height: 1.5),
                      ),
                      SizedBox(height: MyStyle().defaultXSPadding),
                      Text(
                        "$channelName • $view views • $dateTime",
                        style: MyStyle().smallStyle.copyWith(
                          color: MyStyle().lightGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MyStyle().defaultSPadding),
                Icon(LineIcons.verticalEllipsis, size: 20),
              ],
            ),
          ),
          SizedBox(height: MyStyle().defaultSPadding),
        ],
      ),
    );
  }

  InkWell buildTabletCard() {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(videoUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(channelProfile),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1.5),
                    ),
                    SizedBox(height: MyStyle().defaultXSPadding),
                    Text(
                      "$channelName • $view views • $dateTime",
                      style: MyStyle().smallStyle.copyWith(
                        color: MyStyle().lightGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDesktopCard() {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              videoUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(channelProfile),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "$channelName • $view views • $dateTime",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
