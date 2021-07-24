import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_ui/globals.dart' as globals;
import 'package:flutter_app_ui/pages/details.dart';
import 'package:flutter_app_ui/pages/service.dart';
import 'package:flutter_app_ui/services/mealservice.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Profile',
      style: optionStyle,
    ),
    Text(
      'Index 1: Deliveries',
      style: optionStyle,
    ),
    Text(
      'Index 2: Tricycles',
      style: optionStyle,
    ),
    Text(
      'Index 3: Services',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(_selectedIndex ==3){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Myservices()));
    }
  }


  @override
  Widget build(BuildContext context) {
    var productApi = new ProductAPI();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        icon: Icon(Icons.person,  size: 30,),
    label: 'Profile',
    backgroundColor: Colors.blueGrey,
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.delivery_dining,  size: 30,),
    label: 'Deliveries',


    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.electric_car, size: 30,),
    label: 'Tricycles',

    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.miscellaneous_services, size: 30,),
    label: 'Services',

    ),
    ],
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.amber[800],
    onTap: _onItemTapped,
    ),


      backgroundColor: Colors.orangeAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Welcome ' + (globals.username), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('what will you eat today?', style: TextStyle(color: Colors.white, fontSize: 18),),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(icon: Icon(Icons.menu, size: 30, color: Colors.white,), onPressed: (){}),
                )
              ],
            ),
            SizedBox(height: 15.0,),
            Padding(
              padding: const EdgeInsets.only(left:  10.0, right: 10.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search for menu',
                      suffixIcon: IconButton(icon: Icon(Icons.search, color: Colors.black,), onPressed: (){},),
                      border: InputBorder.none


                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Text('Recommended', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    ),
                    Container(
                      width: 70.0,
                      height: 2,
                      color: Colors.white,
                    )
                  ],
                ),

              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  width: 60,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white
                  ),
                  child: Center(child: Text('more')),
                ),
              )
            ],),
            SizedBox(height: 20,),
            SizedBox(height: 400,
                child: FutureBuilder(
                  future: productApi.findAll(),
                  builder: (context, AsyncSnapshot<List> snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.only(left:3.0, right: 3, bottom: 15),
                              child: InkWell(
                                splashColor: Colors.orangeAccent,
                                onTap: () async{
                                 await Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(mealId: snapshot.data[index].mealId)));
                                },
                                child: Container(
                                  width: 280,

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(offset: Offset(0,6), blurRadius: 40, color: Colors.orangeAccent.withOpacity(0.2)),],
                                    borderRadius: BorderRadiusDirectional.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("http://mashfoodapp.pythonanywhere.com/static/images/" + snapshot.data[index].mealPhoto,)
                                    ),


                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 310,),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:1.0, right: 1),
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0)
                                            ),
                                            child:
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                                                    child: Text(snapshot.data[index].mealName, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                                                  ),
                                                ),


                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0, bottom: 5.0),
                                                  child: Text('\GHS' + snapshot.data[index].mealPrice.toString(), style:  TextStyle(fontWeight: FontWeight.normal,fontSize: 18, color: Colors.white),),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),


//Text('Banku')

                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }else{
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),


          )
        ]),
      ),
    );
  }
}
