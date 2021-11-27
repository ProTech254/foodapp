import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/app_screens/calender.dart';
import 'package:foodapp/models/userData.dart';
import 'package:provider/provider.dart';

class ResdetailWidget extends StatefulWidget {
  final String? res_name;
  final String? res_id;
  final String? res_description;
  final String? image;

  const ResdetailWidget({Key? key, this.res_name, this.res_id, this.res_description, this.image}) : super(key: key);



  @override
  _ResdetailWidgetState createState() => _ResdetailWidgetState();
}

class _ResdetailWidgetState extends State<ResdetailWidget> {
  @override
  Widget build(BuildContext context) {
    final user_data= Provider.of<List<UserData>>(context);
    bool role_admin = false;
    print(user_data.length);
    if(user_data.length > 0){
      if(user_data[0].role == 1){
        setState(() {
          print("user not null");
          role_admin = true;
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
          child: Text(widget.res_description! ,style: TextStyle(
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PickDate()));
                },
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                textColor: Color.fromRGBO(0, 160, 227, 1),
                child: Text("Make Reservation",
                    style: TextStyle(fontSize: 15)),
              ),
            ),

          ],
        ),
        role_admin ? Container(
          margin: EdgeInsets.all(10),
          height: 50.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
            onPressed: () async{
              final Query restaurant = Firestore.instance
                  .collection('restaurants').where("restaurantID", isEqualTo: widget.res_id);
              restaurant.getDocuments().then((snaps) async{
                print(snaps.documents.length);
                final String id_doc = snaps.documents[0].documentID;

                await Firestore.instance.collection("restaurants").document(id_doc).delete().then((value){
                  Fluttertoast.showToast(msg: 'Deleted category and its sub categories', backgroundColor: Colors.redAccent);
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


      ],
    );
  }
}
