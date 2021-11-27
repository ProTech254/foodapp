
import 'package:flutter/material.dart';
import 'package:foodapp/includes/productTile.dart';
import 'package:foodapp/models/restaurantData.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/models/userData.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';


class RestaurantsList extends StatefulWidget {
  @override
  _RestaurantsListState createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    final restaurants = Provider.of<List<restaurantData>>(context);
    if(restaurants.length == 0){
      return Center(child: Text('Oops!!,No restaurants'));
    }
    return ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index){

        return RestaurantTile(restaurantsData: restaurants[index],);
          // return ProductTile(productsData: products[index],);
        }

    );
  }
}
