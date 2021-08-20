import 'dart:convert';
import 'package:crunchstudent/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crunchstudent/utils/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegistartionPage extends StatefulWidget {
  @override
  _RegistartionPageState createState() => _RegistartionPageState();
}

class _RegistartionPageState extends State<RegistartionPage> {
  //add button function
  List<dynamicWidget> dynamicList = [];
  List<String> Price = [];
  List<String> Product = [];
  Icon floatingIcon = new Icon(Icons.add);
  addDynamic() {
    if (Product.length != 0) {
      floatingIcon = new Icon(Icons.add);
      Product = [];
      Price = [];
      dynamicList = [];
    }
    setState(() {});
    if (dynamicList.length >= 10) {
      return;
    }
    dynamicList.add(new dynamicWidget());
  }

//end add button function
  var grade1, grade2;
  String radioButtonItem = 'Monthly';
  int id = 1;
  int id1 = 1;
  int monthlydollars = 19;
  int yearlyydollars = 199;
  String name = "";
  bool changeButton = false;
  bool isDisabled = false;
  bool valuefirst = true;
  static Color darkBlueText = Color(0xff032b49);
  final _formKey = GlobalKey<FormState>();
  final List<String> _gradeValues = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  var condition;
  bool _isChecked = true;
  List<String> text = [
    "By proceeding, I agree to Crunch Tutor's Terms of Use and acknowledge that I have read the Privacy Notice.",
    "Bt proceeding, I am also consenting to recive calls or SMS messages, including by automatic dialer,from Crunch Tutor and its affiliates to the number I provide.",
    "By proceeding,I am also agreeing to recive marketing communications(including by automatic dialer) by SMS from Crunch Tutor at the  phone number provided. These messages may promote Crunch Tutor's products and services.I understand that consent to reciving these marketing messages is not required to use Crunch Tuto's service."
  ];
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController lnameController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confpswdController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController staddressController = new TextEditingController();
  final TextEditingController stateController = new TextEditingController();
  final TextEditingController zipcodeController = new TextEditingController();
  final TextEditingController cardnumberController =
      new TextEditingController();
  final TextEditingController malingaddressController =
      new TextEditingController();
  final TextEditingController expiredateController =
      new TextEditingController();
  final TextEditingController cvvController = new TextEditingController();

  //Api integraion method
  moveToHome(
      BuildContext context,
      String name,
      String lname,
      String username,
      String pass,
      String confpaswd,
      String phone,
      String email,
      String staddress,
      String state,
      String zip,
      String cardnum,
      String mailaddres,
      String expiredate,
      String cvv) async {
    print(name);
    print(expiredate);

    Map data = {
      'plus_18': "1",
      'firstname': name,
      'lastname': lname,
      'username': username,
      'email': email,
      'phone': phone,
      'password': pass,
      'street_address': staddress,
      'state': state,
      'zipcode': zip,
      'reg_from': '2',
      'device_id': '00000000-54b3-e7c7-0000-000046bffd97',
      'child': '[{ "name": "sujeet", "grade": 2},{"name":"kumar", "grade":4}]',
      'ipaddress': ''
    };
    var jsonResponse = null;
    var response = await http
        .post(Uri.parse('https://crunchtutor.com/api/sign-up'), body: data);
    jsonResponse = json.decode(response.body);
    print(response);
    print(response.statusCode);
    if (_formKey.currentState!.validate()) {
      if (response.statusCode == 200) {
        setState(() {
          changeButton = true;
          showToastMessage(
              "Your registration succefully done.Please active your account by Email.");
        });
        await Future.delayed(Duration(seconds: 2));
        await Navigator.pushNamed(context, MyRoutes.loginRoute);

        setState(() {
          changeButton = false;
        });
      } else if (response.statusCode == 203) {
        setState(() {
          changeButton = false;
          showToastMessage("Sorry! Account already exists.");
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
    Widget result = new Flexible(flex: 1, child: new Card());

    Widget dynamicTextField = new Flexible(
      flex: 2,
      child: new ListView.builder(
        itemCount: dynamicList.length,
        itemBuilder: (_, index) => dynamicList[index],
      ),
    );
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 35.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkBlueText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 35.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                          child: Padding(
                        child: Text(
                          "Are you 18 year or older",
                          style: TextStyle(
                              fontSize: 13,
                              color: darkBlueText,
                              fontWeight: FontWeight.normal),
                        ),
                        padding: EdgeInsets.only(left: 5),
                      )),
                      Switch(
                          value: isDisabled,
                          onChanged: (check) {
                            //print(check);
                            setState(() {
                              isDisabled = check;
                            });
                          }),
                    ],
                  ),
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
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Enter First name",
                          labelText: "First name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "name cannot be empty";
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
                        controller: lnameController,
                        decoration: InputDecoration(
                          hintText: "Enter Last name",
                          labelText: "Last name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Last name cannot be empty";
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
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "Enter Create login",
                          labelText: "Create login",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Create login cannot be empty";
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
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 6) {
                            return "Password length should be atleast 6";
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
                        obscureText: true,
                        controller: confpswdController,
                        decoration: InputDecoration(
                          hintText: "Enter confirm password",
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Confirm Password cannot be empty";
                          } else if (value.length < 6) {
                            return "Confirm Password length should be atleast 6";
                          }

                          return null;
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
                        controller: phoneController,
                        decoration: InputDecoration(
                          hintText: "Enter phone",
                          labelText: "Phone",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone cannot be empty";
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
                      TextFormField(
                        style: TextStyle(
                          fontSize: 11.0,
                          height: 1.0,
                        ),
                        controller: staddressController,
                        decoration: InputDecoration(
                          hintText: "Enter Streat Address",
                          labelText: "Streat Address",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Streat Address cannot be empty";
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
                        controller: stateController,
                        decoration: InputDecoration(
                          hintText: "Enter State",
                          labelText: "State",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "State cannot be empty";
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
                        controller: zipcodeController,
                        decoration: InputDecoration(
                          hintText: "Enter Zip code",
                          labelText: "Zip code",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Zip code cannot be empty";
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Expanded(
                                child: Padding(
                              child: Text(
                                "Childs Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: darkBlueText),
                              ),
                              padding: EdgeInsets.only(left: 5),
                            )),
                            new Expanded(
                                child: Padding(
                              child: Text(
                                "Childs Grade",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: darkBlueText),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 170,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: new TextFormField(
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    height: 1.0,
                                  ),
                                  // controller: Product,
                                  decoration: const InputDecoration(
                                      labelText: 'Childs Name',
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text("Grade"),
                                      value: this.grade1,
                                      isDense: true,
                                      isExpanded: true,
                                      items: _gradeValues
                                          .map((value) => DropdownMenuItem(
                                                child: Text(value),
                                                value: value,
                                              ))
                                          .toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          this.grade1 = val;
                                          print(val);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                      // SizedBox(
                      //   height: 10.0,
                      // ),
                      SizedBox(
                        child: Product.length == 0 ? dynamicTextField : result,
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RaisedButton.icon(
                          onPressed: addDynamic,
                          // onPressed: () {
                          //   print('Add Child');
                          // },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          label: Text(
                            'Add Child',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          textColor: Colors.white,
                          splashColor: Colors.red,
                          color: Color(0xff2f4aad),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Subscription",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: darkBlueText),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Monthly';
                                id = 1;
                              });
                            },
                          ),
                          Text(
                            'Monthly (\$$monthlydollars)',
                            style: new TextStyle(
                                fontSize: 15.0, color: Color(0xff254b6d)),
                          ),
                          Radio(
                            value: 2,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Yearly';
                                id = 2;
                              });
                            },
                          ),
                          Text(
                            'Yearly (\$$yearlyydollars)',
                            style: new TextStyle(
                                fontSize: 15.0, color: Color(0xff254b6d)),
                          ),
                        ],
                      ),
                      InkWell(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Credit Card Information",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 11),
                            ),
                            Text(
                              "(will be directly recorded into",
                              style: TextStyle(
                                  color: Color(0xff2f4aad), fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        child: Text(
                          "the globally accepted Heartland Payment Portal)",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff2f4aad),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 11.0,
                          height: 1.0,
                        ),
                        controller: cardnumberController,
                        decoration: InputDecoration(
                          hintText: "Enter card number",
                          labelText: "Card Number",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "card number cannot be empty";
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
                        controller: malingaddressController,
                        decoration: InputDecoration(
                          hintText: "Enter mailing address",
                          labelText: "Mailing Address",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "mailing address cannot be empty";
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
                        controller: expiredateController,
                        decoration: InputDecoration(
                          hintText: "Enter expiration date",
                          labelText: "Expiration Date ",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.date_range,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "expiration date cannot be empty";
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
                        controller: cvvController,
                        decoration: InputDecoration(
                          hintText: "Enter cvv",
                          labelText: "CVV",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "cvv cannot be empty";
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        child: Text(
                          "I understand that the information I provide must be complete and accurate to the best of my knowladge.I realize that falsification and/or incomplete information may jeopardize my signin now or in the future. Do you wish to continue?)",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff033259),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: id1,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Yes';
                                id1 = 1;
                              });
                            },
                          ),
                          Text(
                            'Yes',
                            style: new TextStyle(
                                fontSize: 15.0, color: Color(0xff254b6d)),
                          ),
                          Radio(
                            value: 2,
                            groupValue: id1,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'No';
                                id1 = 2;
                              });
                            },
                          ),
                          Text(
                            'No',
                            style: new TextStyle(
                                fontSize: 15.0, color: Color(0xff254b6d)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                child: Container(
                              child: Column(
                                children: text
                                    .map((t) => CheckboxListTile(
                                          // controlAffinity:
                                          //     ListTileControlAffinity.leading,
                                          title: Text(t,
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Color(0xff0c3053),
                                              )),
                                          value: _isChecked,
                                          onChanged: (val) {
                                            setState(() {
                                              _isChecked = val!;
                                            });
                                          },
                                        ))
                                    .toList(),
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Material(
                        color: MyTheme.darkBluebtn,
                        borderRadius:
                            BorderRadius.circular(changeButton ? 50 : 8),
                        child: InkWell(
                          //onTap: () => moveToHome(context),
                          onTap: () => moveToHome(
                              context,
                              nameController.text,
                              lnameController.text,
                              usernameController.text,
                              passwordController.text,
                              confpswdController.text,
                              phoneController.text,
                              emailController.text,
                              staddressController.text,
                              stateController.text,
                              zipcodeController.text,
                              cardnumberController.text,
                              malingaddressController.text,
                              expiredateController.text,
                              cvvController.text),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: changeButton ? 40 : 350,
                            height: 40,
                            alignment: Alignment.center,
                            child: changeButton
                                ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account ? ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: Color(0xff3049ac),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
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

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.BOTTOM, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        backgroundColor: Colors.blue, //background Color for message
        textColor: Colors.white, //message text color
        fontSize: 16.0 //message font size
        );
  }
}

class dynamicWidget extends StatelessWidget {
  TextEditingController Product = new TextEditingController();
  TextEditingController Price = new TextEditingController();
  var grade1;
  final List<String> _gradeValues = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: new EdgeInsets.all(8.0),
      child: ListBody(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 170,
                    height: 40,
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                    child: new TextFormField(
                      style: TextStyle(
                        fontSize: 11.0,
                        height: 1.0,
                      ),
                      // controller: Product,
                      decoration: const InputDecoration(
                          labelText: 'Childs Name',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text("Grade"),
                          value: this.grade1,
                          isDense: true,
                          isExpanded: true,
                          items: _gradeValues
                              .map((value) => DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              this.grade1 = val;
                              print(val);
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  void setState(Null Function() param0) {}
}
