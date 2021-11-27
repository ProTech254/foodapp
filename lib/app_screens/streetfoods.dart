import 'package:flutter/material.dart';
import 'package:foodapp/app_screens/add_streetfood.dart';
import 'package:foodapp/includes/restaurantList.dart';
import 'package:foodapp/includes/streetFoodList.dart';
import 'package:foodapp/models/restaurantData.dart';
import 'package:foodapp/models/streetfoodData.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';

class StreetFoods extends StatefulWidget {
  const StreetFoods({Key? key}) : super(key: key);

  @override
  _StreetFoodsState createState() => _StreetFoodsState();
}

class _StreetFoodsState extends State<StreetFoods> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<streetFoodData>>.value(
          initialData: [],
          value: DatabaseService().streetfoods,
        )

      ],
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.2,
            backgroundColor: Colors.redAccent,

            title: Text('Street Food List', style: TextStyle(color: Colors.white),)
        ),
        body: StreetFoodList(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {

            });
            Navigator.push(context, MaterialPageRoute(builder: (_) =>AddStreetFood()));

          },
          tooltip: 'Add a product',
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      ),

    );
  }
}

