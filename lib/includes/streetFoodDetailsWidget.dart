import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/app_screens/add_reviews.dart';
import 'package:foodapp/app_screens/streetfood_details.dart';
import 'package:foodapp/app_screens/view_reviews.dart';
import 'package:foodapp/includes/starRating.dart';
import 'package:foodapp/models/userData.dart';
import 'package:provider/provider.dart';

class StreetFoodWidget extends StatefulWidget {
  final String? place_name;
  final String? place_id;
  final String? place_description;
  final String? image;
  final String? postedBy;

  const StreetFoodWidget({Key? key, this.place_name, this.postedBy, this.place_id, this.place_description, this.image}) : super(key: key);




  @override
  _StreetFoodWidgetState createState() => _StreetFoodWidgetState();
}

class _StreetFoodWidgetState extends State<StreetFoodWidget> {
  @override
  Widget build(BuildContext context) {
    final user_data= Provider.of<List<UserData>>(context);
    bool posted = false;
    print(user_data.length);
    if(user_data.length > 0){
      if(user_data[0].user_id == widget.postedBy){
        setState(() {
          print("user not null");
          posted = true;
        });
      }else{
        print("No data found");
      }
    }
    return Column(

      children: [
        Container(
          width: 150,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: widget.image != null ?  Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 4, 4.0, 40),
              child: Image.network(widget.image!, fit: BoxFit.cover),
            ): OutlineButton(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.8), width: 1.0),
              onPressed: (){
//
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 40, 14.0, 40),
                child: Icon(Icons.add, color: Colors.grey,),
              ),

            ),
          ),
        ),

        Center(
          child: Text(
            widget.place_description!,style: TextStyle(
              color: Color(0xFF575E67),
              fontFamily: 'Varela',
              fontSize: 24.0
          ),
          ),

        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Container(
              margin: EdgeInsets.all(10),
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                onPressed: () async{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReviewsList()));
                },
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                textColor: Color.fromRGBO(0, 160, 227, 1),
                child: Text("View Reviews",
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddReview(place_id: widget.place_id,)));
                },
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                textColor: Color.fromRGBO(0, 160, 227, 1),
                child: Text("Add Review",
                    style: TextStyle(fontSize: 15)),
              ),
            ),

          ],
        ),
        posted ? Container(
          margin: EdgeInsets.all(10),
          height: 50.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
            onPressed: () async{
              final Query restaurant = Firestore.instance
                  .collection('streetfoods').where("placeID", isEqualTo: widget.place_id);
              restaurant.getDocuments().then((snaps) async{
                print(snaps.documents.length);
                final String id_doc = snaps.documents[0].documentID;

                await Firestore.instance.collection("streetfoods").document(id_doc).delete().then((value){
                  Fluttertoast.showToast(msg: 'Deleted Street food Place', backgroundColor: Colors.redAccent);
                  Navigator.pop(context);
                });
              });
            },
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            textColor: Color.fromRGBO(0, 160, 227, 1),
            child: Text("Delete Restaurant",
                style: TextStyle(fontSize: 15)),
          ),
        ): Container(),
        IconTheme(
          data: IconThemeData(
            color: Colors.amber,
            size: 48,
          ),
          child: StarDisplay(value: 3),
        ),



      ],
    );
  }
}
