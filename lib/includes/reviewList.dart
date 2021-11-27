
import 'package:flutter/material.dart';
import 'package:foodapp/includes/productTile.dart';
import 'package:foodapp/includes/reviewTile.dart';
import 'package:foodapp/includes/streetfoodTile.dart';
import 'package:foodapp/models/restaurantData.dart';
import 'package:foodapp/models/reviewsData.dart';
import 'package:foodapp/models/streetfoodData.dart';
import 'package:foodapp/models/userData.dart';
import 'package:foodapp/services/auth.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';


class ReviewList extends StatefulWidget {
  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    final reviews = Provider.of<List<reviewsData>>(context);

    if(reviews.length == 0){

      return Center(child: Text('There are no reviews yet'));
    }
    return MultiProvider(
      providers: [
        StreamProvider<List<UserData>>.value(
          initialData: [],
          value: DatabaseService().usersById(reviews[0].postedBy!),
        )
      ],
      child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index){
            return reviewTile(reviewData: reviews[index],);

          }

      ),
    );
  }
}
