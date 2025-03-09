import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youtube_ui_clone/screen/settings/family_center.dart';
import 'package:youtube_ui_clone/screen/settings/general_screen.dart';
import 'package:youtube_ui_clone/screen/settings/notification.dart';
import 'package:youtube_ui_clone/screen/settings/privacy.dart';
import 'package:youtube_ui_clone/screen/settings/purchases_member.dart';
import 'package:youtube_ui_clone/screen/settings/switch_account.dart';

const List categoryItems = [
  "All",
  "Music",
  "Live",
  "Deep House",
  "Soul Music",
  "Chill-out Music",
  "Gaming",
  "Meditation Music",
  "Thunder Music",
  "Thunder",
  "Animated Film",
  "Comedy",
  "Basketball",
];

List castItems = [
  {"icon": Icon(Icons.airplay), "title": "Airplay & Bluetooth devices"},
  {"icon": Icon(Icons.tv), "title": "Link with TV code"},
  {"icon": Icon(Icons.info_outline), "title": "Learn More"},
];

const List subscriptionItem = [
  "All",
  "Today",
  "Videos",
  "Short",
  "Live",
  "Posts",
  "Continue watching",
  "Unwatched",
];

List profileItems = [
  {"icon": Icons.switch_account, "title": "Switch account"},
  {"icon": LineIcons.googleLogo, "title": "Google Account"},
  {"icon": Icons.switch_account, "title": "Turn on indigo"},
  {"icon": LineIcons.share, "title": "Share channel"},
];

List settingsItems = [
  {"icon": Icon(Icons.settings), "title": "General", "onTap": GeneralScreen()},
  {
    "icon": Icon(Icons.switch_account),
    "title": "Switch account",
    "onTap": SwitchAccount(),
  },
  {
    "icon": Icon(Icons.family_restroom),
    "title": "Family Center",
    "onTap": FamilyCenter(),
  },
  {
    "icon": Icon(Icons.notifications),
    "title": "Notifications",
    "onTap": SettingNotification(),
  },
  {
    "icon": Icon(Icons.tag_outlined),
    "title": "Purchases and memberships",
    "onTap": PurchasesMember(),
  },
  {
    "icon": Icon(Icons.history),
    "title": "Manage all history",
    "onTap": Privacy(),
  },
  {
    "icon": Icon(Icons.security),
    "title": "Your data in YouTube",
    "onTap": Privacy(),
  },
  {"icon": Icon(Icons.lock), "title": "Privacy", "onTap": Privacy()},
  {
    "icon": Icon(Icons.link_rounded),
    "title": "Connect apps",
    "onTap": Privacy(),
  },
  {
    "icon": Icon(Icons.science),
    "title": "Try experimental new features",
    "onTap": Privacy(),
  },
  {
    "icon": Icon(Icons.hd),
    "title": "Video quality preferences",
    "onTap": Privacy(),
  },
  {"icon": Icon(Icons.play_arrow), "title": "Playback", "onTap": Privacy()},
  {
    "icon": Icon(Icons.download),
    "title": "Backgrounf & download",
    "onTap": Privacy(),
  },
  {"icon": Icon(Icons.upload), "title": "Uploads", "onTap": Privacy()},
  {"icon": Icon(Icons.stream), "title": "Live chat", "onTap": Privacy()},
  {"icon": Icon(Icons.tv), "title": "Watch on TV", "onTap": Privacy()},
  {
    "icon": Icon(Icons.question_mark_rounded),
    "title": "Help",
    "onTap": Privacy(),
  },
  {"icon": Icon(Icons.feedback), "title": "Send feedback", "onTap": Privacy()},
  {
    "icon": Icon(Icons.edit_document),
    "title": "YouTube Terms of Service",
    "onTap": Privacy(),
  },
  {"icon": Icon(Icons.info_outline), "title": "About", "onTap": Privacy()},
];

List historyItem = [
  {"icon": Icon(Icons.delete), "title": "Remove form wattch history"},
  {"icon": Icon(Icons.playlist_play), "title": "Play next in queue"},
  {"icon": Icon(Icons.watch_later), "title": "Save to playlist"},
  {"icon": Icon(Icons.download), "title": "Download"},
  {"icon": Icon(Icons.share), "title": "Share"},
];

List historymenuItem = [
  {"icon": Icon(Icons.history), "title": "Pause watch history"},
  {"icon": Icon(Icons.delete_outline), "title": "Clear all watch history"},
  {"icon": Icon(Icons.settings), "title": "Manage all history"},
];

List playlistItem = [
  {"icon": Icon(Icons.add), "title": "Create new playlist"},
  {"icon": Icon(Icons.question_mark_rounded), "title": "Help & feedback"},
];

List moreItems = [
  {"icon": Icon(Icons.not_interested), "title": "Not interested"},
  {"icon": Icon(Icons.queue_play_next), "title": "Play next in the queue"},
  {"icon": Icon(Icons.queue), "title": "play last in the queue"},
  {"icon": Icon(Icons.watch_later), "title": "Save to watch leter"},
  {"icon": Icon(Icons.playlist_add), "title": "Save to playlist"},
  {"icon": Icon(Icons.file_download), "title": "Download video"},
  {"icon": Icon(Icons.share), "title": "Share"},
  {"icon": Icon(Icons.flag), "title": "Report"},
];
