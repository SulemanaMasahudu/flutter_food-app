import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_ui/pages/drawerpage.dart';


class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  double xoffset = 0;
  double yoffset = 0;
  double scalefactor = 1;
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return
      AnimatedContainer(
          transform: Matrix4.translationValues(xoffset, yoffset, scalefactor),
          duration: Duration(microseconds: 250),

          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     isOpened? IconButton( icon: Icon(Icons.keyboard_backspace, size: 30.0,),
                          onPressed: (){
                            setState(() {
                              xoffset = 0;
                              yoffset = 0;
                              scalefactor = 1;
                              isOpened = false;
                            });
                          }): IconButton(icon: Icon(Icons.menu),
                         onPressed: (){

                           setState(() {
                             xoffset = 200;
                             yoffset = 250;
                             scalefactor = 0.7;
                             isOpened = true;
                           });
                         }),
                      Column(
                        children: [
                          Text('Damongo'),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              Text('Savannah Capital')
                            ],
                          )
                        ],
                      ),
                      CircleAvatar()
                    ],
                  ),
                ),
               Form(child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70.0,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0)
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            filled: true,
                            hintText: 'Username'
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0)
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              filled: true,
                              hintText: 'Username'
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0)
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              filled: true,
                              hintText: 'Username'
                          ),
                        ),
                      )
                    ],
                  )
                  ),

                Center(
                  child: FlatButton(
                    child: Text('Animate Page'),
                    color: Colors.black.withOpacity(0.2),
                    onPressed: (){
                      Navigator.push(context, PageRouteBuilder(
                          transitionsBuilder: (BuildContext context, animation, secanimation, Widget child){
                            animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                            return ScaleTransition(scale: animation,
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (BuildContext context, animation, secanimation){
                        return DrawerPage();
                      }));
                    },
                  ),
                )
              ],
            ),
          ),

      );
  }



}
