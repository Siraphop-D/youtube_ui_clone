import 'package:flutter/material.dart';
import 'package:youtube_ui_clone/screen/profile/download_screen.dart';
import 'package:youtube_ui_clone/screen/profile/history_all.dart';
import 'package:youtube_ui_clone/screen/profile/more_info.dart';
import 'package:youtube_ui_clone/screen/profile/myprofile_screen.dart';
import 'package:youtube_ui_clone/screen/profile/playlist_all.dart';
import 'package:youtube_ui_clone/screen/profile/profile_screen.dart';
import 'package:youtube_ui_clone/screen/profile/your_movie_screen.dart';
import 'package:youtube_ui_clone/screen/profile/your_video_screen.dart';

class ProfileNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/myprofile':
            return MaterialPageRoute(builder: (_) => MyprofileScreen(navigatorKey: navigatorKey,));
          case '/history_all':
            return MaterialPageRoute(builder: (_) => HistoryAll());
          case '/playlist_all':
            return MaterialPageRoute(builder: (_) => PlaylistAll());
          case '/yourvideo':
            return MaterialPageRoute(builder: (_) => YourVideoScreen());
          case '/download':
            return MaterialPageRoute(builder: (_) => DownloadScreen());
          case '/yourmovie':
            return MaterialPageRoute(builder: (_) => YourMovieScreen());
            case '/moreinfo':
            return MaterialPageRoute(builder: (_) => MoreInfo());
          default:
            return MaterialPageRoute(
              builder: (_) => ProfileScreen(navigatorKey: navigatorKey),
            );
        }
      },
    );
  }
}
