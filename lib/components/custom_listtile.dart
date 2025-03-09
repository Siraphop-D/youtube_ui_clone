import 'package:flutter/material.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';


class CustomListTile extends StatelessWidget {
  final String title;
  final Widget leadingIcon;
  final VoidCallback onTap;

  const CustomListTile({
    Key? key, 
    required this.title, 
    required this.leadingIcon, 
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      textColor: MyStyle().white,
      iconColor: MyStyle().white,
      leading: Container(
        padding: EdgeInsets.all(MyStyle().defaultSPadding),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent
        ),
        child: leadingIcon
      ),
      title: Text(title),
    );
  }
}