import 'package:flutter/material.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class SwitchAccount extends StatefulWidget {
  const SwitchAccount({super.key});

  @override
  State<SwitchAccount> createState() => _SwitchAccountState();
}

class _SwitchAccountState extends State<SwitchAccount> {
  late double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: Text("Switch account"),
      ),
      body: Padding(
        padding: EdgeInsets.all(MyStyle().defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Siraphop D",
                      style: TextStyle(fontSize: screenHeight * 0.016),
                    ),
                    Text(
                      "myaccount@gmail.com",
                      style: TextStyle(
                        fontSize: screenHeight * 0.016,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Divider(thickness: 1, color: MyStyle().lightGrey),
            SizedBox(height: screenHeight * 0.01),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: screenHeight * 0.035,
                  backgroundImage: AssetImage("assets/icons/profile.png"),
                ),
                SizedBox(width: screenWidth * 0.05),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Siraphop D',
                      style: TextStyle(
                        color: MyStyle().white,
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '@profilename ',
                      style: TextStyle(
                        color: MyStyle().white,
                        fontSize: screenHeight * 0.015,
                      ),
                    ),
                    Text(
                      "72 subcribers",
                      style: TextStyle(
                        color: MyStyle().white,
                        fontSize: screenHeight * 0.015,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.2),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Edit channel",
                    style: TextStyle(
                      color: MyStyle().blue,
                      fontSize: screenHeight * 0.015,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Divider(thickness: 2, color: MyStyle().lightGrey),
            SizedBox(height: screenHeight * 0.01),
            Row(
              children: [
                Text(
                  "Other account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.016,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "myacc12@gmail.com",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: screenHeight * 0.016,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: screenHeight * 0.035,
                      backgroundImage: AssetImage("assets/icons/profile.png"),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Siraphop D',
                          style: TextStyle(
                            color: MyStyle().white,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'No subscribers',
                          style: TextStyle(
                            color: MyStyle().white,
                            fontSize: screenHeight * 0.015,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Text(
                      "myacc12@gmail.com",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: screenHeight * 0.016,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: screenHeight * 0.035,
                      backgroundImage: AssetImage("assets/icons/profile.png"),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Siraphop D',
                          style: TextStyle(
                            color: MyStyle().white,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'No subscribers',
                          style: TextStyle(
                            color: MyStyle().white,
                            fontSize: screenHeight * 0.015,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
             SizedBox(height: screenHeight * 0.01),
            Divider(thickness: 1, color: MyStyle().lightGrey),
            SizedBox(height: screenHeight * 0.01),
            ListTile(
              leading: Icon(Icons.person_add),title: Text('Add account'),
            ),
             ListTile(
              leading: Icon(Icons.logout),title: Text('Use Youtube signed out'),
            ),
             ListTile(
              leading: Icon(Icons.manage_accounts),title: Text('Manage account on this device'),
            ),
          ],
        ),
      ),
    );
  }
}
