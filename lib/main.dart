import 'package:crunchstudent/pages/forgot_page.dart';
import 'package:crunchstudent/pages/logintest.dart';
import 'package:crunchstudent/pages/skip_page.dart';
import 'package:crunchstudent/pages/splash_page.dart';
import 'package:crunchstudent/pages/verifyoto_page.dart';
import 'package:flutter/material.dart';
import 'package:crunchstudent/pages/login_page.dart';
import 'package:crunchstudent/pages/registration.dart';
import 'package:crunchstudent/utils/routes.dart';
import 'pages/home_page.dart';
import 'widgets/themes.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.logintestRoute,
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
         MyRoutes.logintestRoute: (context) => LoginTestPage(),
        MyRoutes.splashRoute: (context) => ImageSplashScreen(),
        MyRoutes.registrationRoute: (context) => RegistartionPage(),
        MyRoutes.skipRoute: (context) => SkipPage(),
        MyRoutes.forgotRoute: (context) => ForgotPage(),
        MyRoutes.verifyRoute: (context) => VerifyPage(),
       
      },
    );
  }
}


