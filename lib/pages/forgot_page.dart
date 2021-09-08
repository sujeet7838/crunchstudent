import 'dart:convert';
import 'package:crunchstudent/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPage extends StatefulWidget {
 
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {


  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  static Color darkBluebtn = Color(0xff3049ac);
  static Color darkBlueText = Color(0xff0c324d);
  static Color deepBluebtn = Color(0xff0c3256);
  final TextEditingController emailController = new TextEditingController();
  moveToHome(BuildContext context, String email) async {
    Map data = {
      'email': email,
      //'userType': "2",
    };

    if (_formKey.currentState!.validate()) {
      var jsonResponse = null;
      var response = await http.post(
          Uri.parse('https://crunchtutor.com/api/forgot-password'),
          body: data);
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        setState(() {
          changeButton = true;
          showToastMessage("Please check your email for password");
          
        });
        await Future.delayed(Duration(seconds: 1));
        await Navigator.pushNamed(context, MyRoutes.verifyRoute);       
        setState(() {
          changeButton = false;
        });
      } else if (response.statusCode == 203) {
        setState(() {
          changeButton = false;
          showToastMessage("Incorrect Email address!");
        });
      } else if (response.statusCode == 400) {
        setState(() {
          changeButton = false;
          showToastMessage("Error! Input data is missing");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 65.0,
                ),
                Image.asset(
                  "assets/images/graphic.png",
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: 200.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Forgot your password?",
                  style: TextStyle(
                    fontSize: 15,
                    color: deepBluebtn,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Enter your registered email below to recive",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: darkBlueText,
                      backgroundColor: Colors.white,
                      fontSize: 11,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "instrations about resetting the password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: darkBlueText,
                      backgroundColor: Colors.white,
                      fontSize: 11,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          fontSize: 11.0,
                          height: 1.0,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Enter email",
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Remember password ? ",
                              style: TextStyle(
                                  color: darkBlueText,
                                  backgroundColor: Colors.white,
                                  fontStyle: FontStyle.normal),
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: darkBluebtn,
                                  backgroundColor: Colors.white,
                                  fontStyle: FontStyle.normal),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Material(
                        color: darkBluebtn,
                        borderRadius:
                            BorderRadius.circular(changeButton ? 50 : 8),
                        child: InkWell(
                          //onTap: () => moveToHome(context),
                          onTap: () =>
                              moveToHome(context, emailController.text),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: changeButton ? 50 : 250,
                            height: 50,
                            alignment: Alignment.center,
                            child: changeButton
                                ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Send",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.BOTTOM, //where you want to show, top, bottom
        timeInSecForIosWeb: 3, //for iOS only
        backgroundColor: Colors.blue, //background Color for message
        textColor: Colors.white, //message text color
        fontSize: 16.0 //message font size
        );
  }
}
