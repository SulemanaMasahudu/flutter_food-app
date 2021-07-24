import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_ui/services/mealservice.dart';
import 'package:flutter_app_ui/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurtItemsPage extends StatefulWidget {
  int userId;
  CurtItemsPage({Key key, this.userId}) : super(key: key);
  @override
  _CurtItemsPageState createState() => _CurtItemsPageState();
}

class _CurtItemsPageState extends State<CurtItemsPage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var productapi = ProductAPI();
    var current_quant = 1;
    bool plus_pressed = false;
    var mysum;



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('Curt Items  ' + globals.ItemsInCurtCount.toString(), style: TextStyle(color: Colors.black),),
        leading: IconButton(icon: Icon(Icons.notifications, color: Colors.purple,), onPressed: (){}),
        actions: [
          IconButton(icon: Icon(Icons.delete, color: Colors.black,),
            onPressed: (){}, tooltip: 'Delete All',
           splashColor: Colors.blueGrey,)
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.orangeAccent,
            child: Column(
              children: [
                SizedBox(
                  height: size.height*0.78,
                ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   children: [
                     Expanded(child: Text('Total price GH' + globals.mysum.toString(), style: TextStyle(color: Colors.white),)),
                     Expanded(child:OutlineButton(onPressed: (){}, shape: StadiumBorder(),  color: Colors.white,
                       borderSide: BorderSide(
                           color: Colors.blue, style: BorderStyle.solid,
                           width: 1),
                         child: Text('Checkout', style: TextStyle(color: Colors.white),)))
                   ],
                 ),
               )
              ],
            ),

          ),
          SizedBox(
            height: size.height * 0.75,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
              ),

              child: FutureBuilder(
                future: productapi.findAllInCurt(globals.myuser_id),
                builder: (context, AsyncSnapshot<List> snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                        itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 200.0,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 190,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage("http://mashfoodapp.pythonanywhere.com/static/images/" + snapshot.data[index].mealPhoto,)
                                              )
                                            ),
                                          ),
                                        ),
                                        Expanded(child:Padding(
                                          padding: const EdgeInsets.only(top:10.0, left: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot.data[index].mealName, style: TextStyle( ),),
                                              Row(
                                                children: [
                                                  IconButton(icon: Icon(Icons.add),
                                                      onPressed: (){
                                                        plus_pressed = true;
                                                        current_quant = snapshot.data[index].mealQuantity ++;

                                                        void  dosamtin() async{
                                                      String url = 'http://mashfoodapp.pythonanywhere.com/increase_number/' +
                                                          globals.myuser_id
                                                              .toString();
                                                      int meal_quant = snapshot
                                                          .data[index]
                                                          .mealQuantity;
                                                      var current_meal_quant = meal_quant++;

                                                      final body = {
                                                        'userId': globals
                                                            .myuser_id,
                                                        'mealId': snapshot
                                                            .data[index].mealId,
                                                        'current_meal_quant': current_meal_quant
                                                      };
                                                      final response = await http
                                                          .post(url, body: json
                                                          .encode(body));
                                                      final decodedMessage = json.decode(response.body) as Map<String, dynamic>;
                                                      print(response.body);

                                                      if (response.statusCode ==
                                                          200) {
                                                         setState(() {
                                                           snapshot.data[index].mealQuantity;
                                                           globals.mysum = decodedMessage['response'];
                                                         });



                                                      }
                                                    }
                                                       dosamtin();


                                                      }),
                                                  IconButton(icon: Icon(Icons.exposure_minus_1), onPressed: (){

                                                    plus_pressed = true;
                                                    if(snapshot.data[index].mealQuantity > 1){
                                                    current_quant = snapshot.data[index].mealQuantity --;
                                                    }


                                                    void  dosamtin() async{
                                                      String url = 'http://mashfoodapp.pythonanywhere.com/decrease_number/' +
                                                          globals.myuser_id
                                                              .toString();
                                                      int meal_quant = snapshot
                                                          .data[index]
                                                          .mealQuantity;
                                                      var current_meal_quant = meal_quant--;

                                                      final body = {
                                                        'userId': globals
                                                            .myuser_id,
                                                        'mealId': snapshot
                                                            .data[index].mealId,
                                                        'current_meal_quant': current_meal_quant
                                                      };
                                                      final response = await http
                                                          .post(url, body: json
                                                          .encode(body));
                                                      final decodedMessage = json.decode(response.body) as Map<String, dynamic>;
                                                      print(response.body);

                                                      if (response.statusCode ==
                                                          200) {
                                                        setState(() {
                                                          snapshot.data[index].mealQuantity;
                                                          globals.mysum = decodedMessage['response'];
                                                        });



                                                      }
                                                    }

                                                      dosamtin();




                                                  })
                                                ],
                                              ),
                                             Text('Quantity: ' + snapshot.data[index].mealQuantity.toString())
                                            ],
                                          ),)
                                        ),

                                        Expanded(child: Padding(
                                          padding: const EdgeInsets.only(left: 70.0),
                                          child: IconButton(icon: Icon(Icons.delete, color: Colors.red,),
                                            onPressed: (){

                                              showAlertDialog(BuildContext context) {
                                                // set up the buttons
                                                Widget cancelButton = FlatButton(
                                                  child: Text("Cancel"),
                                                  onPressed:  () {
                                                    Navigator.pop(context);
                                                  },
                                                );
                                                Widget continueButton = FlatButton(
                                                  child: Text("Continue"),
                                                  onPressed:  () {

                                                    void  dosamtin() async{
                                                      String url = 'http://mashfoodapp.pythonanywhere.com/delete_fromcurt';
                                                      final body = {
                                                        'userId': globals
                                                            .myuser_id,
                                                        'mealId': snapshot
                                                            .data[index].mealId,
                                                      };
                                                      final response = await http
                                                          .post(url, body: json
                                                          .encode(body));
                                                      print(response.body);
                                                      final decodedMessage = json.decode(response.body) as Map<String, dynamic>;

                                                      if (response.statusCode ==
                                                          200) {
                                                        setState(() {
                                                          globals.ItemsInCurtCount = decodedMessage['response'];
                                                          globals.mysum = decodedMessage['total'];

                                                        });


                                                      }
                                                    }

                                                    dosamtin();
                                                    Navigator.pop(context);

                                                  },

                                                );

                                                // set up the AlertDialog
                                                AlertDialog alert = AlertDialog(

                                                  content: Text("Do you really want to delete?"),
                                                  actions: [
                                                    cancelButton,
                                                    continueButton,
                                                  ],
                                                );

                                                // show the dialog
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return alert;
                                                  },
                                                );
                                              }

                                              showAlertDialog(context);
                                            }, splashColor: Colors.blueGrey,),
                                        )),

                                      ],
                                    ),

                                ),
                              ),

                          );
                        
                        }
                        );
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              
            ),
          )
        ],
      ),
    );
  }





}
