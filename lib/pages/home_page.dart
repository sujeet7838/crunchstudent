import 'dart:convert';
import 'package:crunchstudent/widgets/drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
late SharedPreferences sharedPreferences;
  var res, drinks;
  var userId;


  fetchData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    //print(sharedPreferences.getString("UserData"));
    var UserData1 = sharedPreferences.getString("UserData");
    var userName = jsonDecode(UserData1!)["data"];
     userId = userName["id"];
   // print(userId);
    setState(() {});
  }

  var mainsub, secondsub, grade,timeZone;
  late List subjdata, gradedata;
  var categUri = 'https://crunchtutor.com/api/category-list';
  Future<String> getSubjData() async {
    var res = await http
        .get(Uri.parse(categUri), headers: {"Accept": "application/json"});
    String body = res.body;
    Map<String, dynamic> jsonResponse = json.decode(body);
    subjdata = jsonResponse['data'];
    return "Sucess";
  }

  //  grade list
  var gradeuri = 'https://crunchtutor.com/api/grade-list';
  Future<String> getgradeData() async {
    var res = await http
        .get(Uri.parse(gradeuri), headers: {"Accept": "application/json"});
    String body = res.body;
    Map<String, dynamic> jsonResponse = json.decode(body);
    gradedata = jsonResponse['data'];
    return "Sucess";
  }

  //using date time picker
  String finalDate = 'Select Date';
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        var formattedDate =
            "${currentDate.year}-${currentDate.month}-${currentDate.day}";
        finalDate = formattedDate.toString();
       // print(finalDate);
      });
  }

  //Timepicker
  String? _selectedTime = 'Select time';
  Future<void> _show() async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: false),
              child: child!);
        });
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context).substring(0,4);
       // print(_selectedTime);
      });
    }
  }

  //file picker method
  //var timedata = '5:30';
  var filePath;
  var filebytes;
  Future getPdfAndUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'docx'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
     /// print(file.name);
     // print(file.bytes);
      //print(file.size);
      print(file.extension);
      //print(file.path);
      filePath = file.path;
      print(this.filePath);
      //String fileName = result.files.first.name;
      filebytes = result.files.first.bytes;
      //String fileName = result.files.first.name;
    } else {
      // User canceled the picker
    }
  }
  //TimeZone

  final List<String> _timeZoneValues = [
    'AKST',
    'PST',
    'MST',
    'CST',
    'EST',
  ];

  //Api Integration Method
  String name = "";
  final TextEditingController problemdescController =
      new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;
  moveToHome(problem) async {
     print(userId);
    Map data = {
      'parent_id': '${userId}',
      'category_id': this.mainsub,
      'grade_id': this.grade,
      'problem_file': "",
      'description': problem,
      'session_datetime': finalDate + " " + '$_selectedTime',
      'search_from': '1',
      'session_zone':this.timeZone
    };
    var jsonResponse = null;
    if (_formKey.currentState!.validate()) {
      var response = await http.post(
          Uri.parse('https://crunchtutor.com/api/find-tutor'),
          body: data);
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          changeButton = true;
          showToastMessage(
              "Problem uploaded successfully done, within 1 hr experienced tutors help to solve of your problem");
        });
        await Future.delayed(Duration(seconds: 2));
        //await Navigator.pushNamed(context, MyRoutes.homeRoute);

        setState(() {
          changeButton = false;
        });
      } else if (response.statusCode == 203) {
        setState(() {
          changeButton = false;
          showToastMessage("Problem uploaded successfully not done.");
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
     fetchData();
    getSubjData().whenComplete(() {
      setState(() {});
    });
    getgradeData().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f7ff),
      appBar: AppBar(
        backgroundColor: Color(0xfff4f7ff),
        //title: Text("Welcome"),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(20),
                  elevation: 15,
                  child: SizedBox(
                    height: 630,
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                "Get Instant Help for Your Child from Experienced Tutors",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff0c3053),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: new DropdownButton(
                                    items: subjdata.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['name']),
                                        value: item['id'].toString(),
                                      );
                                    }).toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        this.mainsub = newVal;
                                        print(this.mainsub);
                                      });
                                    },
                                    value: this.mainsub,
                                    hint: Text("Subject"),
                                  ),
                                ),
                              ),
                            ),
                            //  SizedBox(height: 10.0,),
                            // Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                            // child:InputDecorator(
                            // decoration: InputDecoration(
                            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                            //         contentPadding: EdgeInsets.all(10),),
                            //     child: DropdownButtonHideUnderline(
                            //         child: DropdownButton<String>(
                            //             hint: Text("Second Subject"),
                            //           value:this.secondsub,
                            //             isDense: true,
                            //             isExpanded: true,
                            //        items: _secondublectValues
                            //         .map((value) => DropdownMenuItem(
                            //               child: Text(value),
                            //               value: value,
                            //             ))
                            //         .toList(),
                            //             onChanged: (val) {
                            //                 setState(() {
                            //                   this.secondsub=val;
                            //                 });
                            //             },
                            //         ),
                            //     ),
                            // ),
                            // ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text("Grade"),
                                    value: this.grade,
                                    isDense: true,
                                    isExpanded: true,
                                    // items: _gradeValues
                                    //     .map((value) => DropdownMenuItem(
                                    //           child: Text(value),
                                    //           value: value,
                                    //         ))
                                    //     .toList(),
                                    items: gradedata.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['name']),
                                        value: item['id'].toString(),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        this.grade = val;
                                        print(this.grade);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextField(
                                //controller: _eateryController,
                                // autofocus: false,
                                //enabled: false,
                                decoration: InputDecoration(
                                  labelText: finalDate.toString(),
                                  hintText: finalDate.toString(),
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(5),
                                  suffixIcon: Icon(
                                    Icons.date_range,
                                  ),
                                ),
                                onTap: () {
                                  print("calendar");
                                  // _show();
                                  _selectDate(context);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextField(
                                //enabled: false,
                                style: TextStyle(
                                    fontSize: 11.0,
                                    height: 2.0,
                                    color: Colors.black),
                                //controller: _eateryController,
                                autofocus: false,
                                decoration: InputDecoration(
                                  labelText: _selectedTime,
                                  hintText: _selectedTime,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(5),
                                  suffixIcon: Icon(
                                    Icons.timer,
                                  ),
                                ),
                                onTap: () {
                                  print("time");
                                  // _show();
                                  _show();
                                },
                              ),
                            ),

                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text("Session Zone"),
                                    value: this.timeZone,
                                    isDense: true,
                                    isExpanded: true,
                                    items: _timeZoneValues
                                        .map((value) => DropdownMenuItem(
                                              child: Text(value),
                                              value: value,
                                            ))
                                        .toList(),
                                    // items: gradedata.map((item) {
                                    //   return new DropdownMenuItem(
                                    //     child: new Text(item['name']),
                                    //     value: item['id'].toString(),
                                    //   );
                                    // }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        this.timeZone = val;
                                        print(this.timeZone);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.top,
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      height: 3.0,
                                      color: Colors.black),
                                  autocorrect: true,
                                  controller: problemdescController,
                                  decoration: InputDecoration(
                                    hintText: 'Describe the problem (optional)',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Color(0xff3049ac))),
                                    onPrimary: Colors.grey,
                                    primary: Color(0xffe8effd),
                                    minimumSize: Size(350, 50),
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.save_alt,
                                    color: Colors.grey,
                                  ),
                                  label: Text('Upload the Problem'),
                                  onPressed: () {
                                    print('Upload the problem');
                                    getPdfAndUpload();
                                  },
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                            //   Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                            // child:Row(children: <Widget>[
                            //     Expanded(
                            //       child: new Container(
                            //         margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                            //         child: Divider(
                            //         color: Colors.black,
                            //         height: 50,
                            //         )),
                            //     ),

                            //     Text("OR"),

                            //     Expanded(
                            //       child: new Container(
                            //         margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                            //         child: Divider(
                            //         color: Colors.black,
                            //         height: 50,
                            //         )),
                            //     ),
                            //     ]),
                            //   ),

                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Color(0xff3049ac))),
                                    onPrimary: Colors.grey,
                                    primary: Color(0xffe8effd),
                                    minimumSize: Size(350, 50),
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.grey,
                                  ),
                                  label: Text('Take a Photo'),
                                  onPressed: () {
                                    print('Take a photo.');
                                  },
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: ElevatedButton(
                                  child: Text("Find Me a Tutor"),
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Color(0xff3049ac),
                                    minimumSize: Size(350, 50),
                                  ),
                                  onPressed: () =>
                                      moveToHome(problemdescController.text),
                                )),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.BOTTOM, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        backgroundColor: Colors.blue, //background Color for message
        textColor: Colors.white, //message text color
        fontSize: 15.0 //message font size
        );
  }
}
