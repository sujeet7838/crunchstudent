import 'dart:convert';
import 'package:crunchstudent/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginTestPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginTestPage> {
  String name = "";
  bool changeButton = false;
  bool _passwordVisible = false;
  static Color darkBluebtn = Color(0xff3049ac);
  static Color darkBlueText = Color(0xff032b49);
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //Api Integration Method
  moveToHome(BuildContext context,String email,pass) async {
      Map data = {
      'username':email,
      'password': pass,
      'loginType': "2",
    };
    var jsonResponse = null;
     var response = await http.post(Uri.parse('https://crunchtutor.com/api/login'), body: data);
      jsonResponse = json.decode(response.body);
      print(response.statusCode);
       print(jsonResponse);
    if (_formKey.currentState!.validate()) {
      if(response.statusCode==200){
       setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context,MyRoutes.homeRoute);
       setState(() {
        changeButton = false;
      });
      }else if(response.statusCode==203){
      setState(() {
        changeButton = false;
        showToastMessage("Incorrect Email Id OR Password.");
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.0,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 0.0),
                 child:Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover, 
                ),),
               
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 35.0),
               child: Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                     color: Color(0xff0c3053),
                   ),
                 ),
                ),
                
                   Padding(
                padding: const EdgeInsets.symmetric(vertical: 00.0, horizontal: 35.0),
               child:  Text(
                  "Enter your credentials to continue",
                  style: TextStyle(
                    fontSize: 13,
                    color: darkBlueText
                  ),
                ),
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
                          controller: emailController,
                          decoration: InputDecoration(
                          hintText: "Enter user name",
                          labelText: "User Name",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                          Icons.check,
                           ),
                          ),
                          validator: (value) {
                          if (value!.isEmpty) {
                            return "User name cannot be empty";
                          }else if (value.length < 6) {
                            return "User name length should be atleast 6";
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
                            fontSize: 11.0,
                           height: 1.0,                
                           ),
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          labelText: "Password",
                            border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  // use _setState that belong to StatefulBuilder
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
                      
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 4) {
                            return "Password length should be atleast 6";
                          }

                          return null;
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
                          onTap: () => moveToHome(context,emailController.text, passwordController.text),
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
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                      InkWell(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       Text("Forgot password?",style: TextStyle(color:darkBluebtn, backgroundColor: Colors.white,)),
                      ], 
                     ),
                    onTap: (){
                      //Navigator.pushNamed(context, '/forgot_page');
                      Navigator.pushNamed(context, '/forgot');
                    },
                  ), 
                      
                    SizedBox(
                    height: 110,
                  ),
                  
              InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Dnon't have an account ? ",style: TextStyle(color: darkBlueText, backgroundColor: Colors.white,),),
                  Text("Sign Up",style: TextStyle(color: darkBluebtn, backgroundColor: Colors.white,),),
                ], 
              ),
              onTap: (){
                Navigator.pushNamed(context, '/registration');
              },
              
            ), 
                    
                    ],
                  ),
                )
              ],
            ),
          ),
        ));

        
  }
  void showToastMessage(String message){
     Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.BOTTOM, //where you want to show, top, bottom
        timeInSecForIosWeb: 3, //for iOS only
        backgroundColor: Colors.red, //background Color for message
        textColor: Colors.white, //message text color
        fontSize: 25.0 //message font size
    );
  }
}