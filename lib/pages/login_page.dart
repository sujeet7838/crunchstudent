import 'package:crunchstudent/pages/home_page.dart';
import 'package:crunchstudent/pages/registration.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
// import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import './widgets/loginform.dart';
// import './widgets/socialicons.dart';
// import './customicons.dart';
// import './register_page.dart';
// import './main.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  bool _isSelected = false;
  bool _isLoading = false;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  void _radio(){
    setState(() {
     _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected)=>Container(
    width: 16.0,
    height: 16.0,
    padding: EdgeInsets.all(2.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(width:  2.0, color: Colors.grey),
    ),
    child: isSelected ? Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[700],

      ),
    )
    :Container(),
  );

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
     // width: 120,
     // height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  signIn(String email, pass) async {
    print("sgjhshgjf");
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map data = {
      'input': email,
      'password': pass,
      'user_type': "2",
      'name':"Paris",
      'lat':"88.258",
      'lng':"22.587",
      'deviceToken':"12345kjhk",
      'deviceType':"android"
    };
    var jsonResponse;
     var response = await http.post(Uri.parse('http://airport-paris-cab.com/api/paris/login'), body: data);
    //  var response = await http.post("http://subicjobs.com/api/login", body: data);
    
   if(jsonResponse.value==0) {
        print("hello");
        setState(() {
          //_isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Sending Message"),
    ));
        });
        //print(jsonResponse['success']['token']);
      // sharedPreferences.setString("token", jsonResponse['success']['token']);
      }else{
        print("hello354");
      _isLoading = false;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
      }

     debugPrint(response.statusCode.toString() );
    if(response.statusCode ==200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse.value);
  
      if(jsonResponse.value==0) {
        print("hello");
        setState(() {
          //_isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Sending Message"),
    ));
        });
        //print(jsonResponse['success']['token']);
      // sharedPreferences.setString("token", jsonResponse['success']['token']);
      }else{
        print("hello354");
      _isLoading = false;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
       print("hello000");
    }
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.instance=ScreenUtil.getInstance()..init(context);
    // ScreenUtil.instance = ScreenUtil(width: 770, height: 1334, allowFontScaling: true);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
   
    return Scaffold(
      backgroundColor: Colors.white,
     // resizeToAvoidBottomPadding: true,
      body: Container(
        child: _isLoading ? Center(child: CircularProgressIndicator()) :  Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: <Widget>[
            //     Padding(
            //       padding: EdgeInsets.only(top: 30),
            //       child: Image(image: AssetImage('images/subicjobs-login-header.jpg'),),
            //     )
            //   ],
            // ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 30.0, top: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Image(image: AssetImage(
                        //   'images/subicjobs-login-logo.jpg'),
                        //   width: 110,
                        //   height: 110,
                        //   ),
                        Text("SubicJobs",
                          style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            //fontSize:  ScreenUtil.getInstance().setSp(46),
                            letterSpacing: .6,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                          height: 5,
                    ),
                    //form
                    Container(
                      width: double.infinity,
                     // height: 450,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0,15.0),
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0,-10.0),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30, top: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("LOGIN", style:TextStyle(
                              fontSize: 18,
                                fontFamily: "Poppins-Bold",
                                letterSpacing: .6,
                              )),
                              SizedBox(
                                height:5,
                              ),
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:10,
                              ),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "password",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                Text("Forgot Password?", 
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "Poppins-Medium",
                                  //fontSize: ScreenUtil.getInstance().setSp(28)
                                ),)
                              ],),
                          
                            ],
                          ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 12,),
                            GestureDetector(
                              onTap: _radio,
                              child: radioButton(_isSelected),
                            ),
                            SizedBox(width: 8.0,),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                fontFamily: "Poppines-Medium", fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          child: Container(
                           // width: 330.0,
                           // height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF17ead9),
                                  Color(0xFF6078ea),
                                ]
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [BoxShadow(
                                color:(Color(0xFF6078ea).withOpacity(.3)),
                                offset: Offset(0.0, 8.0),
                                blurRadius: 8.0,
                                )
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: emailController.text == "" || passwordController.text == "" ? null : () {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  signIn(emailController.text, passwordController.text);
                                },
                                child: Center(
                                  child: Text(
                                    "Signin",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 18,
                                      letterSpacing: 1.0
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                   SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // horizontal
                        horizontalLine(),
                        Text("Social Login",
                          style:TextStyle(
                            fontFamily: "Poppins-medium",
                            fontSize: 16.0
                          ),
                        ),
                        horizontalLine(),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // children: <Widget>[
                      //   SocialIcon(
                      //     [ Color(0xFF102397),
                      //       Color(0xFF187adf),
                      //       Color(0xFF00eaf8),],
                      //     CustomIcons.facebook,
                      //     (){},
                      //   ),
                      //   SocialIcon(
                      //     [ Color(0xFFff4f38),
                      //       Color(0xFFff355d),],
                      //     CustomIcons.google,
                      //     (){},
                      //   ),
                      // ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("New User?",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){ return RegistartionPage();})),
                          child: Text("Signup",
                          style: TextStyle(
                            color: Color(0xFF5d74e3),
                            fontFamily: "Poppins-Bold"
                          ),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}