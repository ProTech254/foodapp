import 'package:flutter/material.dart';
import 'package:foodapp/includes/streetFoodDetailsWidget.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/models/userData.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';

class StreetFoodDetails extends StatefulWidget {
  final String? place_name;
  final String? place_id;
  final String? place_description;

  final String? image;
  final String? postedBy;

  const StreetFoodDetails({Key? key, this.place_name, this.postedBy, this.place_id, this.place_description, this.image}) : super(key: key);



  @override
  _StreetFoodDetailsState createState() => _StreetFoodDetailsState();
}

class _StreetFoodDetailsState extends State<StreetFoodDetails> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<UserData>>.value(
          value: DatabaseService().usersById(user!.uid),
          initialData: [],
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          title: Text("Street Food details"),
          backgroundColor: Colors.redAccent,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.close, color: Colors.white,)),
        ),
        body: StreetFoodWidget(place_name: widget.place_name,postedBy: widget.postedBy, place_description: widget.place_description, place_id: widget.place_id, image: widget.image,)
      ),
    );
  }
}
