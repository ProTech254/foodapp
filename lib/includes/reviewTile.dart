
import 'package:flutter/material.dart';
import 'package:foodapp/app_screens/streetfood_details.dart';
import 'package:foodapp/includes/starRating.dart';
import 'package:foodapp/models/restaurantData.dart';
import 'package:foodapp/models/reviewsData.dart';
import 'package:foodapp/models/reviewsData.dart';
import 'package:foodapp/models/reviewsData.dart';
import 'package:foodapp/models/streetfoodData.dart';
import 'package:foodapp/models/userData.dart';
import 'package:provider/provider.dart';

class reviewTile extends StatelessWidget {

  // final ProductsData productsData;
  final reviewsData? reviewData;
  reviewTile({ this.reviewData});
  @override

  Widget build(BuildContext context) {
    final postBy = Provider.of<List<UserData>>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: InkWell(

          child: ListTile(
            leading: Text(postBy[0].firstname!, style: TextStyle(fontSize: 17),),
            title: Text("This is a review"),
            subtitle: Text("20/09/2021"),
            trailing: StarDisplay(value: 4,),
          ),
        ),
      ),
    );
  }
}


