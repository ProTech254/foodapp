import 'package:flutter/material.dart';
import 'package:foodapp/app_screens/add_streetfood.dart';
import 'package:foodapp/includes/forumList.dart';
import 'package:foodapp/includes/restaurantList.dart';
import 'package:foodapp/includes/streetFoodList.dart';
import 'package:foodapp/models/forumsData.dart';
import 'package:foodapp/models/restaurantData.dart';
import 'package:foodapp/models/streetfoodData.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';

class Forums extends StatefulWidget {
  const Forums({Key? key}) : super(key: key);

  @override
  _ForumsState createState() => _ForumsState();
}

class _ForumsState extends State<Forums> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<ForumData>>.value(
          initialData: [],
          value: DatabaseService().forums,
        )

      ],
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.2,
            backgroundColor: Colors.redAccent,

            title: Text('All forums', style: TextStyle(color: Colors.white),)
        ),
        body: ForumList(),


      ),

    );
  }
}

