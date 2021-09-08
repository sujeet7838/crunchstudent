import 'dart:convert';
import 'package:crunchstudent/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VerifyPage extends StatefulWidget {
  
  @override
  _VerifyPageState createState() => _VerifyPageState();
}
class _VerifyPageState extends State<VerifyPage> {
  final TextEditingController codeController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  String name = "";
  String useremail='';
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  static Color darkBluebtn = Color(0xff3049ac);
  static Color darkBlueText = Color(0xff0c324d);
  static Color deepBluebtn = Color(0xff0c3256);
 
dynamic getString(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? _res = prefs.getString("$key");
    return _res;
}

 
  moveToHome(BuildContext context,String scode, String pswd) async {
      Map data = {
          'user_id':'8',
      'secret_code': scode,
      'password':pswd
    };
      if (_formKey.currentState!.validate()) {
      var jsonResponse = null;
      var response = await http.post(
          Uri.parse('https://crunchtutor.com/api/reset-password'),
          body: data);
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        setState(() {
          changeButton = true;
            showToastMessage("your password has been updated successfully");
        });
        await Future.delayed(Duration(seconds: 1));
        await Navigator.pushNamed(context, MyRoutes.loginRoute);
        setState(() {
          changeButton = false;
         
        });
      } else if (response.statusCode == 203) {
        setState(() {
          changeButton = false;
          showToastMessage("Sorry! wrong secret code.");
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
                  height: 55.0,
                ),
                Image.asset(
                  "assets/images/otp.png",
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: 200.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Code Verification",
                  style: TextStyle(
                    fontSize: 15,
                    color: deepBluebtn,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Enter your code send to $useremail",
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
                          fontSize: 13.0,
                          height: 1.0,
                        ),
                        //keyboardType: TextInputType.emailAddress,
                         controller: codeController,
                        decoration: InputDecoration(
                          hintText: "Enter Code",
                          labelText: "Code",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Code cannot be empty";
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
                      TextFormField(
                          style: TextStyle(
                          fontSize: 13.0,
                          height: 1.0,
                        ),
                        //keyboardType: TextInputType.visiblePassword,
                         obscureText: true,
                         controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
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
                              "Don't recive the code? ",
                              style: TextStyle(
                                  color: darkBlueText,
                                  backgroundColor: Colors.white,
                                  fontStyle: FontStyle.normal),
                            ),
                            Text(
                              "Resend Code",
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
                        height: 40.0,
                      ),
                      Material(
                        color: darkBluebtn,
                        borderRadius:
                            BorderRadius.circular(changeButton ? 50 : 8),
                        child: InkWell(
                          //onTap: () => moveToHome(context),
                           onTap: () => moveToHome(context, codeController.text,passwordController.text),
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
                                    "Verify & Proceed",
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
