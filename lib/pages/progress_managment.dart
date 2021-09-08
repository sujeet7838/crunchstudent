import 'package:crunchstudent/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ProgressManagementPage extends StatefulWidget {
  @override
  _ProgressManagementState createState() => _ProgressManagementState();
}

class _ProgressManagementState extends State<ProgressManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f7ff),
      appBar: AppBar(
        backgroundColor: Color(0xfff4f7ff),
        title: SizedBox(child: Text("Progress Management", style: TextStyle(fontSize: 13),)),
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



 