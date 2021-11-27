
import 'package:flutter/material.dart';
import 'package:foodapp/app_screens/streetfood_details.dart';
import 'package:foodapp/models/restaurantData.dart';
import 'package:foodapp/models/streetfoodData.dart';

class StreetfoodTile extends StatelessWidget {

  // final ProductsData productsData;
  final streetFoodData? streefoodsData;
  StreetfoodTile({ this.streefoodsData});
  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => StreetFoodDetails(
              place_name: streefoodsData!.placeName!,
              place_id: streefoodsData!.placeID!,
              place_description: streefoodsData!.description,
              image: streefoodsData!.image,
              postedBy: streefoodsData!.postedBy!,
            )));
          },
          child: ListTile(
            leading: Image.network(streefoodsData!.image!, fit: BoxFit.cover),
            title: Text(streefoodsData!.placeName!),
            subtitle: Text(streefoodsData!.description!),
          ),
        ),
      ),
    );
  }
}


