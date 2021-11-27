
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/app_screens/restaurants.dart';
import 'package:foodapp/app_screens/streetfoods.dart';
import 'package:foodapp/includes/drawer.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/models/userData.dart';
import 'package:foodapp/services/auth.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print("user id");
    print(user!.uid);
    return StreamProvider<List<UserData>>.value(
      initialData: [],
      value: DatabaseService().usersById(user.uid),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Foodie App'),
          elevation: 0.3,
        ),
        drawer: NavDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(user.uid),
              Container(
                margin: EdgeInsets.all(10),
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: Colors.deepOrange)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Restaurants()));
                  },
                  padding: EdgeInsets.all(10.0),
                  color: Color.fromRGBO(0, 160, 227, 1),
                  textColor: Colors.white,
                  child: Text("Restaurants",
                      style: TextStyle(fontSize: 15)),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => StreetFoods()));
                  },
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  textColor: Color.fromRGBO(0, 160, 227, 1),
                  child: Text("Street Food",
                      style: TextStyle(fontSize: 15)),
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                  onPressed: () async{

                  },
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  textColor: Color.fromRGBO(0, 160, 227, 1),
                  child: Text("Forum Activity",
                      style: TextStyle(fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
