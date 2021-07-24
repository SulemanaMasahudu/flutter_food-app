import 'package:flutter/material.dart';
import 'package:flutter_app_ui/pages/drawerpage.dart';
import 'package:flutter_app_ui/pages/indexpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app_ui/globals.dart' as globals;


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String nameEmail = '';
  String password = '';
  String myresponse = '';
  bool ispassObscured = true;
  bool checkedValue = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> _validatemyfields() async{
   final validate = _formKey.currentState.validate();
   if(!validate){
     return;
   }
   _formKey.currentState.save();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 70.0,),
                Text('Login Here', style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),

                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                    child: Text(myresponse, style: TextStyle(color: Colors.red),)),

                SizedBox(height: 30.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Form( key: _formKey,
                        child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Username or Email'
                          ),
                          validator: (String value){
                            // ignore: missing_return
                            if(value.isEmpty) {
                              return 'This field can not be empty';
                            }
                          },
                          onSaved: (String value){
                            nameEmail = value;
                            globals.username = value;
                          },
                        ),
                        SizedBox(height: 25.0,),
                        TextFormField(
                          obscureText: ispassObscured,
                          decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: ispassObscured?
                              IconButton(icon: Icon(Icons.visibility_off), onPressed: (){
                                setState(() {
                                  ispassObscured = false;
                                });
                              },) :
                              IconButton(icon: Icon(Icons.visibility), onPressed: (){
                                setState(() {
                                  ispassObscured = true;
                                });
                              },),
                              hintText: 'Password'
                          ),
                          validator: (String value){
                            if(value.isEmpty){
                              // ignore: missing_return, missing_return
                              return 'This field can not be empty';
                            }
                          },
                          onSaved: (String value){
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        SizedBox(height: 20,),
                        Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Checkbox(value: checkedValue,
                                    onChanged: (newValue){
                                  setState(() {
                                    checkedValue = newValue;
                                    //print(checkedValue);
                                  });

                                }),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 30.0, left: 20),
                                child: Text('Remember Me', style: TextStyle(fontSize: 15),),
                              )
                            ],

                          ),



                        SizedBox(height: 30.0,),
                            OutlineButton(
                              shape: StadiumBorder(),
                              splashColor: Colors.white,
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid,
                                  width: 2),
                              onPressed: () async{
                              _validatemyfields();
                              String url = 'http://mashfoodapp.pythonanywhere.com/umustlogin';
                              final body = {'name': nameEmail, 'password': password, 'checkedValue':checkedValue};
                              final response = await http.post(url, body: json.encode(body));

                              final decodedMessage = json.decode(response.body) as Map<String, dynamic>;
                              if(response.statusCode == 200){
                                var finalResponse = decodedMessage['message'];
                                var myuser_id = decodedMessage['user'];
                                setState((){
                                  myresponse = finalResponse;
                                  globals.myuser_id = myuser_id;
                                  print(myuser_id);
                                  globals.ItemsInCurtCount = decodedMessage['count'];
                                  globals.mysum = decodedMessage['total'];
                                  print(globals.mysum);

                                  if(myresponse.startsWith('success')) {
                                    globals.Is_Authenticated = true;
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>IndexPage()));
                                  }

                                });
                              }
                            },
                              child: Text('Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                              ),
                            ),
                        SizedBox(height: 30.0,),
                        
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                          children: [
                            Expanded(child: Text('Dont have an Account? Click button to register')),

                            Expanded(child:RaisedButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DrawerPage()));
                                }, child: Text('Create An Account'),)),
                            
                          ],
                        )),
                        
                        SizedBox(height: 20,),
                        


                      ],
                    )),
                  ),
                )
              ],

            ),
          ),
        ),
      ),
    );
  }
}
