
import 'package:flutter/material.dart';
import 'package:foodapp/includes/productTile.dart';
import 'package:foodapp/includes/streetfoodTile.dart';
import 'package:foodapp/models/restaurantData.dart';
import 'package:foodapp/models/streetfoodData.dart';
import 'package:provider/provider.dart';


class StreetFoodList extends StatefulWidget {
  @override
  _StreetFoodListState createState() => _StreetFoodListState();
}

class _StreetFoodListState extends State<StreetFoodList> {
  @override
  Widget build(BuildContext context) {
    final streetfood = Provider.of<List<streetFoodData>>(context);
    if(streetfood.length == 0){
      return Center(child: Text('Oops!!,No restaurants'));
    }
    return ListView.builder(
        itemCount: streetfood.length,
        itemBuilder: (context, index){
          return StreetfoodTile(streefoodsData: streetfood[index],);
          // return RestaurantTile(restaurantsData: restaurants[index],);
          // return ProductTile(productsData: products[index],);
        }

    );
  }
}
