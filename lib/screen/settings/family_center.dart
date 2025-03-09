import 'package:flutter/material.dart';

class FamilyCenter extends StatefulWidget {
  const FamilyCenter({super.key});

  @override
  State<FamilyCenter> createState() => _FamilyCenterState();
}

class _FamilyCenterState extends State<FamilyCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: Text("Family Center"),
      ),
    );
  }
}
