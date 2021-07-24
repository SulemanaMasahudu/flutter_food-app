
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_ui/models/meal.dart';
import 'package:flutter_app_ui/pages/curt.dart';
import 'package:flutter_app_ui/services/mealservice.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_ui/globals.dart' as globals;
import 'dart:convert';

class DetailsPage extends StatefulWidget {
  int mealId;
  DetailsPage({Key key, this.mealId}) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var mynumber = 1;
  var currentamount;
  var originalprice ;
  var curt_count;

  void add() {

    setState(() {
        mynumber++;
        currentamount = mynumber * originalprice;
      });

  }

  void minus() {
    if(mynumber > 1){
      setState(() {
        mynumber--;
        currentamount = mynumber * originalprice;
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var productApi = ProductAPI();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(icon: Icon(Icons.keyboard_backspace,color: Colors.blueGrey, size: 25.0,),onPressed: (){
          Navigator.pop(context);
        }),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
                child:  Stack(
                      children:[
                    IconButton(icon: Icon(Icons.shopping_cart, color: Colors.blueGrey, size: 25.0,),
                      onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CurtItemsPage()));
                      }
                             ),
                        Positioned(
                          left: 25.0,
                          top: 5,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),

                            child: Center(child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Text(globals.ItemsInCurtCount.toString()),
                            )),
                          ),
                        )
                  ]
    ),
                )


        ],
      ),

      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child:  Column(
          children: [
            SizedBox(
              height: size.height,
              child:  FutureBuilder(
                  future: productApi.find(widget.mealId),
                  builder: (context, AsyncSnapshot<Meal> snapshot){
                    if(snapshot.hasData){
                        originalprice = snapshot.data.mealPrice;
                      return Stack(
                children: [
                  Positioned(
                    top: 150,
                      child: Container(color: Colors.red)),


                  Container(
                      height: 400,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage("http://mashfoodapp.pythonanywhere.com/static/images/" + snapshot.data.mealPhoto,)
                          )
                      )),

                  Container(
                    height: 400,
                    margin: EdgeInsets.only(top: size.height *0.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),

                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(snapshot.data.mealName, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25.0),),
                              ),
                              Container()
                            ],
                          ),

                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 10, right: 10),
                          child: Text(snapshot.data.mealDescription),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(color: Colors.red,
                                          borderRadius: BorderRadius.circular(60.0),
                                      ),
                                      child: IconButton(icon:
                                      Icon(Icons.exposure_minus_1_outlined,),
                                          onPressed: (){
                                            minus();
                                      }),
                                    ),
                                  ),
                                  mynumber > 9 ? Text('$mynumber') : Text('\0' +'$mynumber'),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(color: Colors.orangeAccent,
                                          borderRadius: BorderRadius.circular(60.0)
                                      ),
                                      child: IconButton(icon: Icon(Icons.add,), onPressed: (){
                                        add();
                                      }),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: currentamount==null?Text('\GHS' +'$originalprice'):  Text('\GHS' +'$currentamount'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 30.0,),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                decoration: BoxDecoration(color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: IconButton(icon: Icon(Icons.add_circle_outline),
                                    splashColor: Colors.red,
                                    onPressed: () async{
                                      String url = 'http://mashfoodapp.pythonanywhere.com/addtocurt';
                                      final body = {'meal_id': snapshot.data.mealId, 'meal_price': originalprice,'meal_photo':snapshot.data.mealPhoto,'meal_name':snapshot.data.mealName,'user_id': globals.myuser_id,'meal_quantity':mynumber};
                                      final response = await http.post(url, body: json.encode(body));
                                      final decodedMessage = json.decode(response.body) as Map<String, dynamic>;
                                      if(response.statusCode == 200){
                                        setState(() {
                                          globals.ItemsInCurtCount = decodedMessage['count'];
                                          globals.mysum = decodedMessage['total'];
                                        });
                                      }
                                      print(response.statusCode);
                                      print(globals.ItemsInCurtCount);

                                }),
                              ),

                              FlatButton(
                                splashColor: Colors.red,
                                onPressed: ()async{
                                String url = 'http://mashfoodapp.pythonanywhere.com/order';
                                final body = {'meal_id': snapshot.data.mealId, 'meal_price': originalprice,'meal_photo':snapshot.data.mealPhoto,'meal_name':snapshot.data.mealName,'user_id': globals.myuser_id,'meal_quantity':mynumber};
                                final response = await http.post(url, body: json.encode(body));
                                print(response.statusCode);
                              },
                                child:  Row(
                                  children: [
                                    Icon(Icons.shopping_cart),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text('Order'),
                                    )
                                  ],),
                                minWidth: 200.0,
                                height: 40,
                                color: Colors.blueGrey,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),



                ]
              );
                  } else{
                      return Center(child: CircularProgressIndicator());
                    }
                  }),

            )

          ],
        )
));
  }
}



