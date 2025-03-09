import 'package:flutter/material.dart';

class PurchasesMember extends StatefulWidget {
  const PurchasesMember({super.key});

  @override
  State<PurchasesMember> createState() => _PurchasesMemberState();
}

class _PurchasesMemberState extends State<PurchasesMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: Text("Purchases & Membership"),
      ),
    );
  }
}
