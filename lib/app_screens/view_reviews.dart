import 'package:flutter/material.dart';
import 'package:foodapp/includes/reviewList.dart';
import 'package:foodapp/includes/streetFoodList.dart';
import 'package:foodapp/models/reviewsData.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';

class ReviewsList extends StatefulWidget {
  final String? postID;

  const ReviewsList({Key? key, this.postID}) : super(key: key);

  @override
  _ReviewsListState createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<reviewsData>>.value(
          initialData: [],
          value: DatabaseService().reviews,
        )

      ],
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.2,
            backgroundColor: Colors.redAccent,

            title: Text('Review List', style: TextStyle(color: Colors.white),)
        ),
        body: ReviewList(),


      ),

    );
  }


}
