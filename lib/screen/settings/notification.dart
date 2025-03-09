import 'package:flutter/material.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class SettingNotification extends StatefulWidget {
  const SettingNotification({super.key});

  @override
  State<SettingNotification> createState() => _SettingNotificationState();
}

class _SettingNotificationState extends State<SettingNotification> {
  bool scheduled = false;
  bool subscription = false;
  bool recommendvideo = true;
  bool recommendways = false;
  bool activityOnCh = false;
  bool postSuggestion = false;
  bool activityOnCommet = false;
  bool mentions = true;
  bool otherreusing = false;
  bool productUpdate = false;
  bool promotional = false;
  bool watchTV = false;
  bool disableSound = true;
  bool newbadges = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: Text("Notification"),
      ),
      body: ListView(
        children: [
          buildSwitchTile(
            "Scheduled digest",
            scheduled,
            (val) {
              setState(() => scheduled = val);
            },
            description:
                "Get all your notifications as a daily digest. Tap to customize delivery time.",
          ),

          buildSwitchTile(
            "Subscriptions",
            subscription,
            (val) {
              setState(() => subscription = val);
            },
            description:
                "Notify me about activity from the channels I'm subscribed to",
          ),
          buildListTile(
            "Channel settings",
            "Tap here to maage notification settings for each subscribed channel",
          ),
          buildSwitchTile(
            "Recommended videos",
            recommendvideo,
            (val) {
              setState(() => recommendvideo = val);
            },
            description:
                "Notify me of videos I might like based on what I watch",
          ),
          buildSwitchTile(
            "Recommended ways to create",
            recommendways,
            (val) {
              setState(() => recommendways = val);
            },
            description: "Notify me with recommended trends and ways to create",
          ),
          buildSwitchTile(
            "Activity on my channel",
            activityOnCh,
            (val) {
              setState(() => activityOnCh = val);
            },
            description:
                "Notify me about comments and other activity on my channel or videos",
          ),
          buildSwitchTile(
            "Postt suggestions",
            postSuggestion,
            (val) {
              setState(() => postSuggestion = val);
            },
            description: "Notify me of suggestion posts for my channel",
          ),
          buildSwitchTile(
            "Activity on my comments",
            activityOnCommet,
            (val) {
              setState(() => activityOnCommet = val);
            },
            description:
                "Notify me about replies, like, and other activity on my comments, and activity on my post other channels",
          ),
          buildSwitchTile(
            "Mentions",
            mentions,
            (val) {
              setState(() => mentions = val);
            },
            description: "Notify me when others mention my channel",
          ),
          buildSwitchTile(
            "Others reusing my content",
            otherreusing,
            (val) {
              setState(() => otherreusing = val);
            },
            description:
                "Notify me when other share, remix, or respond to my content on their channels",
          ),
          buildSwitchTile(
            "Product updates",
            productUpdate,
            (val) {
              setState(() => productUpdate = val);
            },
            description: "Notify me of new product updates and announcements",
          ),
          buildSwitchTile(
            "Promotional content and offerings",
            promotional,
            (val) {
              setState(() => promotional = val);
            },
            description:
                "Noyify me of promotional content and offering, like members-only perks",
          ),
          buildSwitchTile(
            "Watch on TV",
            watchTV,
            (val) {
              setState(() => watchTV = val);
            },
            description: "Suggest videos I might like to watch on TV.",
          ),
          buildSwitchTile(
            "Disable sound & vibrations",
            disableSound,
            (val) {
              setState(() => disableSound = val);
            },
            description:
                "Silence notifications during the hours you specify. Tap to customize time.",
          ),
          buildSwitchTile(
            "New badges",
            newbadges,
            (val) {
              setState(() => newbadges = val);
            },
            description:
                "Notify me on Youtube and Youtube Music when I receive a new badge",
          ),
        ],
      ),
    );
  }

  // Widget สำหรับสร้าง ListTile + Switch
  Widget buildSwitchTile(
    String title,
    bool value,
    Function(bool) onChanged, {
    String? description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: Text(title),
          value: value,
          onChanged: onChanged,
          activeColor: MyStyle().blue,
          inactiveThumbColor: MyStyle().lightGrey,
          inactiveTrackColor: MyStyle().grey,
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(description, style: TextStyle(color: Colors.grey)),
          ),
      ],
    );
  }

  // Widget สำหรับสร้าง ListTile ธรรมดา
  Widget buildListTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle:
          subtitle.isNotEmpty
              ? Text(subtitle, style: TextStyle(color: Colors.grey))
              : null,
      onTap: () {},
    );
  }
}
