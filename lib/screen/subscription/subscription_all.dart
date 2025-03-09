import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youtube_ui_clone/components/custom_listtile.dart';
import 'package:youtube_ui_clone/item/category_item.dart';
import 'package:youtube_ui_clone/screen/search/search_screen.dart';
import 'package:youtube_ui_clone/screen/subscription/notification_status.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class SubscriptionAll extends StatefulWidget {
  final VoidCallback onBack;
  const SubscriptionAll({super.key, required this.onBack});

  @override
  State<SubscriptionAll> createState() => _SubscriptionAllState();
}

class _SubscriptionAllState extends State<SubscriptionAll> {
  late double screenWidth, screenHeight;
  List<dynamic> channel = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadJsonData();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: Text("All subscriptions"),
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
            onPressed: onTabHelp,
            splashRadius: 25,
            icon: Icon(LineIcons.verticalEllipsis, size: 25),
          ),
        ],
      ),
      body: Expanded(child: buildChannel()),
    );
  }

  Future<void> loadJsonData() async {
    try {
      String jsonString = await rootBundle.loadString(
        'assets/json/channel.json',
      );
      List<dynamic> jsonData = jsonDecode(jsonString);

      if (mounted) {
        setState(() {
          channel = jsonData;
        });
      }
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  Widget buildChannel() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(MyStyle().defaultSPadding),
      child:
          channel.isEmpty
              ? CircularProgressIndicator()
              : SizedBox(
                height: screenHeight * 0.752,
                width: screenWidth,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  itemCount: channel.length,
                  itemBuilder: (context, index) {
                    final channelID =
                        channel[index]['channelID'] ?? "default_id";

                    return InkWell(
                      onTap: () {},
                      child: ListTile(
                        contentPadding: EdgeInsets.zero, // ให้ชิดขอบซ้ายขวา
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            channel[index]["channelProfile"]!,
                          ),
                        ),
                        title: Text(channel[index]["channelName"]!),
                        trailing:
                            BlocBuilder<NotificationBloc, NotificationState>(
                              builder: (context, state) {
                                final status =
                                    state.NotificationSetting[channelID] ??
                                    NotificationStatus.none;
                                return Container(
                                  width: screenWidth * 0.16,
                                  height: screenHeight * 0.045,
                                  decoration: BoxDecoration(
                                    color: MyStyle().grey,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: IconButton(
                                    onPressed:
                                        () => showNotificationDialog(
                                          context,
                                          channelID,
                                        ),
                                    icon: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          getNotificationIcon(status),
                                          size: screenHeight * 0.025,
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          size: screenHeight * 0.025,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                      ),
                    );
                  },
                ),
              ),
    );
  }

  IconData getNotificationIcon(NotificationStatus status) {
    switch (status) {
      case NotificationStatus.all:
        return Icons.notifications_active;
      case NotificationStatus.personalized:
        return Icons.notifications;
      case NotificationStatus.none:
        return Icons.notifications_off;
    }
  }

  void showNotificationDialog(BuildContext context, String channelId) {
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              final currentStatus =
                  state.NotificationSetting[channelId] ??
                  NotificationStatus.none;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.notifications_active),
                    title: const Text("All"),
                    trailing:
                        currentStatus == NotificationStatus.all
                            ? const Icon(Icons.check)
                            : null,
                    onTap: () {
                      context.read<NotificationBloc>().add(
                        UpdateNotification(channelId, NotificationStatus.all),
                      );
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text("Personalized"),
                    trailing:
                        currentStatus == NotificationStatus.personalized
                            ? const Icon(Icons.check)
                            : null,
                    onTap: () {
                      context.read<NotificationBloc>().add(
                        UpdateNotification(
                          channelId,
                          NotificationStatus.personalized,
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications_off),
                    title: const Text("None"),
                    trailing:
                        currentStatus == NotificationStatus.none
                            ? const Icon(Icons.check)
                            : null,
                    onTap: () {
                      context.read<NotificationBloc>().add(
                        UpdateNotification(channelId, NotificationStatus.none),
                      );
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_remove),
                    title: const Text("Unsubscribe"),
                    onTap: () {
                      // Handle unsubscribe action
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    });
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

  onTabHelp() {
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
              CustomListTile(
                title: "Help & feedback",
                leadingIcon: Icon(LineIcons.questionCircle),
                onTap: () {},
              ),
              SizedBox(height: MyStyle().defaultLPadding),
            ],
          ),
        );
      },
    );
  }
}
