import 'package:crunchstudent/pages/editprofile.dart';
import 'package:crunchstudent/pages/forgot_page.dart';
import 'package:crunchstudent/pages/logintest.dart';
import 'package:crunchstudent/pages/past_sessition.dart';
import 'package:crunchstudent/pages/progress_managment.dart';
import 'package:crunchstudent/pages/registrationnew.dart';
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
      initialRoute: MyRoutes.loginRoute,
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
        MyRoutes.registrationnewRoute: (context) => Registrationnew(),
        MyRoutes.editprofileRoute: (context) => EditProfilePage(),
        MyRoutes.pastsessionRoute: (context) => PastSessionPage(),
        MyRoutes.progressmanagmentRoute: (context) => ProgressManagementPage(),
      },
    );
  }
}
