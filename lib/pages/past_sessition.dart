import 'package:crunchstudent/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PastSessionPage extends StatefulWidget {
  @override
  _PastSessionState createState() => _PastSessionState();
}

class _PastSessionState extends State<PastSessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f7ff),
      appBar: AppBar(
        backgroundColor: Color(0xfff4f7ff),
        title: Text("Past Session"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notification_add,
              color: Color(0xff0c3053),
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: Icon(
              Icons.account_circle_sharp,
              color: Color(0xff0c3053),
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
        drawer: MyDrawer(),
    );
  }
}



 