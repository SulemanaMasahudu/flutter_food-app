import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_ui/pages/loginpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool isTextObsecured = true;
  bool isTextRObsecured = true;
  String name = '';
  String email = '';
  String password = '';
  String final_response = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatpasswordController = TextEditingController();

  Future<void> _saveData()async{
    final validation = _formKey.currentState.validate();
    if(!validation){
      return;
    }
    _formKey.currentState.save();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SingleChildScrollView(
        child: Container(

          child: Center(
            child: Form(key: _formKey,
                child: Column(
              children: [
                SizedBox(height: 40,),
                CircleAvatar(
                  radius: 70.0,
                ),
                SizedBox(height: 40,),
                final_response.isNotEmpty?Column(
                   children: [
                     Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),

                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(final_response, style: TextStyle(fontSize: 20),),
                        ),
                      ),
                ),
                     SizedBox(height: 40,)
                   ],
                 )

                 : Container(),

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
                        hintText: 'Name'
                    ),
                    // ignore: missing_return
                    validator: (String value){
                      if(value.isEmpty){
                        return 'This field can not be empty';
                      }
                      if(value.length < 5){
                        return "User name can not have less than five chareacters";
                      }
                    },
                    onSaved: (String value){
                      name = value;
                    },
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        filled: true,
                        hintText: 'Email'
                    ),
                    // ignore: missing_return
                    validator: (String value){
                      if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
                        return 'Invalid Email Address';
                      }
                      if(value.isEmpty){
                        return "Email field can not be empty";
                      }

                    },
                    onSaved: (String value){
                      email = value;
                    },
                  ),
                ),
                SizedBox(height: 15,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: isTextObsecured,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: isTextObsecured?
                        IconButton(icon: Icon(Icons.visibility_off),
                          onPressed: (){
                            setState(() {
                              isTextObsecured = false;
                            });
                          },
                        )
                            :
                        IconButton(icon: Icon(Icons.visibility),
                      onPressed: (){
                        setState(() {
                          isTextObsecured = true;
                        });
                          },),
                        filled: true,
                        hintText: 'Password'
                    ),
                    // ignore: missing_return
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Password field can not be empty';
                      }
                      if(value.length < 6){
                        return 'Field can not not have less than 6 characters';
                      }

                    },
                    onSaved: (String value){
                      password = value;
                    },
                  ),
                ),
                SizedBox(height: 15,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: isTextRObsecured,
                    controller: _repeatpasswordController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: isTextRObsecured? IconButton(icon: Icon(Icons.visibility_off), onPressed: (){
                          setState(() {
                            isTextRObsecured = false;
                          });
                        },)
                            : IconButton(icon: Icon(Icons.visibility), onPressed: (){
                              setState(() {
                                isTextRObsecured = true;
                              });
                        },),
                        filled: true,
                        hintText: 'Repeat Password'
                    ),
                    // ignore: missing_return
                    validator: (String value){
                      if(_passwordController.text != _repeatpasswordController.text){
                        // ignore: missing_return
                        return 'This field can not be different from the password field';
                      }
                      if(value.isEmpty){
                        return 'This field can not be empty';
                      }
                    },

                  ),
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  child: Text('Register', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),),
                    onPressed: ()async{
                    _saveData();
                    print('hello word');
                    final url = 'http://mashfoodapp.pythonanywhere.com/umustwork';
                    final body = {'name':name, 'email':email, 'password':password};
                    var response = await http.post(url, body: json.encode(body));
                    print(response.statusCode);
                    if(response.statusCode == 200){
                      var decoded_response = json.decode(response.body) as Map<String,dynamic>;
                      setState(() {
                        final_response = decoded_response['message'];
                        name = '';
                        email = '';
                        if(final_response.startsWith('Account')){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                        }

                      });
                    }

                    }
                    ),
                SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                    Expanded(child: Text('YOU HAVE AN ACCOUNT ALREADY? ')),
                    Expanded(child: RaisedButton(child: Text('Login Here',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20.0)),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      },))
                  ],),
                )
                
              ],
            )

            )),
          ),

        ),
    );
  }
}
