import 'package:flutter/material.dart';
import 'package:flutter_app_ui/pages/drawerpage.dart';
import 'package:flutter_app_ui/pages/homepage.dart';
import 'package:flutter_app_ui/pages/loginpage.dart';
import 'package:flutter_app_ui/pages/indexpage.dart';
import 'package:flutter_app_ui/globals.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: globals.Is_Authenticated? IndexPage() : LoginPage(),
    );
  }
}

