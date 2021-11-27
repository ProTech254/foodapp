
import 'package:flutter/material.dart';
import 'package:foodapp/app_screens/res_details.dart';
import 'package:foodapp/models/restaurantData.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/models/userData.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';

class RestaurantTile extends StatelessWidget {

  // final ProductsData productsData;
  final restaurantData? restaurantsData;
  RestaurantTile({ this.restaurantsData});
  @override

  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResDetails(
              res_name: restaurantsData!.restaurantName!,
              res_description: restaurantsData!.description!,
              res_id: restaurantsData!.restaurantID,
              image: restaurantsData!.image,
            )));
          },
          child: ListTile(
            leading: Image.network(restaurantsData!.image!, fit: BoxFit.cover),
            title: Text(restaurantsData!.restaurantName!),
            subtitle: Text(restaurantsData!.description!),
          ),
        ),
      ),
    );
  }
}


