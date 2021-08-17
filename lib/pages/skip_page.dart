import 'package:crunchstudent/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class SkipPage extends StatefulWidget {
  @override
  _SkipPageState createState() => _SkipPageState();
}
class _SkipPageState extends State<SkipPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: Text('Skip', style: TextStyle(
              color: MyTheme.darkBluebtn,
              fontSize: 18,
              fontWeight: FontWeight.w400
            ),),
          )
        ],
        
      ),
      
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //          child: Container(
  //       child: ListView(
  //         padding: EdgeInsets.zero,
  //         children: [
         
  //          ListTile(
  //             leading: Icon(
  //               CupertinoIcons.home,
  //               color: MyTheme.darkBluebtn,
  //             ),
  //             title: Text(
  //               "Dashboard",
  //               textScaleFactor: 1.2,
  //               style: TextStyle(
  //                 color: MyTheme.darkBlueText,
  //               ),
  //             ),
  //           ),
  //           ListTile(
  //             leading: Icon(
  //               CupertinoIcons.profile_circled,
  //               color: MyTheme.darkBluebtn,
  //             ),
  //             title: Text(
  //               "Edit Profile",
  //               textScaleFactor: 1.2,
  //               style: TextStyle(
  //                 color: MyTheme.darkBlueText,
  //               ),
  //             ),
  //           ),
  //           ListTile(
  //             leading: Icon(
  //               CupertinoIcons.mail,
  //               color: MyTheme.darkBluebtn,
  //             ),
  //             title: Text(
  //               "Past session",
  //               textScaleFactor: 1.2,
  //               style: TextStyle(
  //                 color: MyTheme.darkBlueText,
  //               ),
  //             ),
  //           ),
  //              ListTile(
  //             leading: Icon(
  //               CupertinoIcons.mail,
  //               color:MyTheme.darkBluebtn,
  //             ),
  //             title: Text(
  //               "Progress Management",
  //               textScaleFactor: 1.2,
  //               style: TextStyle(
  //                 color: MyTheme.darkBlueText,
  //               ),
  //             ),
  //           ),
  //              ListTile(
  //             leading: Icon(
  //               CupertinoIcons.mail,
  //               color: MyTheme.darkBluebtn,
  //             ),
  //             title: Text(
  //               "FAQs",
  //               textScaleFactor: 1.2,
  //               style: TextStyle(
  //                 color: MyTheme.darkBlueText,
  //               ),
  //             ),
  //           ),
           
           
  //         ],
  //       ),
  //     ),
  //   );
  // }

}