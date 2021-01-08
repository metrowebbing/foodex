import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String uid, phoneNumber;
  void initState() {
    this.uid = "";
    this.phoneNumber = "";
    FirebaseAuth.instance.currentUser().then((val) {
      setState(() {
        this.uid = val.uid;
        this.phoneNumber = val.phoneNumber;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: Text("Welcome to HomePage\n$uid,\n$phoneNumber"),
      ),
    );
  }
}
