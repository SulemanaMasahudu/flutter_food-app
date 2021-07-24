import 'package:flutter/material.dart';
import 'package:flutter_app_ui/pages/drawerpage.dart';
import 'package:flutter_app_ui/pages/secondpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            DrawerPage(),
            SecondPage(),
          ],
        ),
      ),
    );
  }
}
