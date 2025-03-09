import 'package:flutter/material.dart';
import 'package:youtube_ui_clone/utility/my_style.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  bool remindBreak = false;
  bool remindBedtime = false;
  bool restrictedMode = false;
  bool earnBadges = true;
  bool nerdStats = false;

  String selectedLanguage = "English";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: Text("General"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          buildSwitchTile("Remind me to take a break", remindBreak, (val) {
            setState(() => remindBreak = val);
          }),
          buildSwitchTile("Remind me when it’s bedtime", remindBedtime, (val) {
            setState(() => remindBedtime = val);
          }),
          buildListTile("Appearance", "Dark theme"),
          buildDropdownTile(
            "App Language",
            selectedLanguage,
            ["English", "Thai", "Spanish"],
            (val) {
              setState(() => selectedLanguage = val);
            },
          ),
          buildSwitchTile(
            "Restricted Mode",
            restrictedMode,
            (val) {
              setState(() => restrictedMode = val);
            },
            description:
                "This helps hide potentially mature videos. No filter is 100% accurate.",
          ),
          buildSwitchTile(
            "Earn badges",
            earnBadges,
            (val) {
              setState(() => earnBadges = val);
            },
            description: "Receive badges across all YouTube apps",
          ),
          buildListTile("Location", "United States"),
          buildSwitchTile("Stats for nerds", nerdStats, (val) {
            setState(() => nerdStats = val);
          }),
          buildListTile("Default apps", ""),
          buildListTile("Siri Shortcuts", ""),
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
  Widget buildListTile(String title, String trailing) {
    return ListTile(
      title: Text(title),
      trailing:
          trailing.isNotEmpty
              ? Text(trailing, style: TextStyle(color: Colors.grey))
              : null,
      onTap: () {},
    );
  }

  // Widget สำหรับสร้าง Dropdown
  Widget buildDropdownTile(
    String title,
    String selectedValue,
    List<String> options,
    Function(String) onChanged,
  ) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<String>(
        value: selectedValue,
        dropdownColor: Colors.black,
        items:
            options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
        onChanged: (val) => onChanged(val!),
      ),
    );
  }
}
