import 'package:flutter/material.dart';
import 'package:foodapp/includes/restaurantList.dart';
import 'package:foodapp/models/restaurantData.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/models/userData.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({Key? key}) : super(key: key);

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return MultiProvider(
      providers: [

        StreamProvider<List<restaurantData>>.value(
            initialData: [],
            value: DatabaseService().restaurants,
        )

      ],
      child: Scaffold(
          appBar: AppBar(
              elevation: 0.2,
              backgroundColor: Colors.redAccent,

              title: Text('Restaurant List', style: TextStyle(color: Colors.white),)
          ),
          body: RestaurantsList(),

        ),


    );
  }
  }

