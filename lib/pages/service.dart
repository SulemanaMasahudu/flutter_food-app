import 'package:flutter/material.dart';

class Myservices extends StatefulWidget {
  @override
  _MyservicesState createState() => _MyservicesState();
}

class _MyservicesState extends State<Myservices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('We render the following services at the comfort of your Home', style: TextStyle(fontSize: 30),),
            )
          ],
        ),
      ),

    );
  }
}
