import 'package:crunchstudent/utils/routes.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatefulWidget { 
  @override
  _VerifyPageState createState() => _VerifyPageState();
}
class _VerifyPageState extends State<VerifyPage> {    

  //   @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: AppBar(
  //       elevation: 0,
  //       iconTheme: IconThemeData(color: Colors.black),
  //       backgroundColor: Colors.white,
        
  //     ),
      
  //   );
  // }    
  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  static Color darkBluebtn = Color(0xff3049ac);
  static Color darkBlueText = Color(0xff0c324d);
  static Color deepBluebtn = Color(0xff0c3256);
  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.loginRoute);
      setState(() {
        changeButton = false;
      });
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
                 Text("Enter your code send to sujeet@gmail.com",
                 textAlign: TextAlign.center,
                 style: TextStyle(color: darkBlueText, backgroundColor: Colors.white,fontSize: 11,fontStyle: FontStyle.normal,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
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
                  InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't recive the code? ",style: TextStyle(color: darkBlueText, backgroundColor: Colors.white,fontStyle: FontStyle.normal),),
                      Text("Resend Code",style: TextStyle(color: darkBluebtn, backgroundColor: Colors.white,fontStyle: FontStyle.normal),),
                    ], 
                  ),
                  onTap: (){
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
                          onTap: () => moveToHome(context),
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
}
