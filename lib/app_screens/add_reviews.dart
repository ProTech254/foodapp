

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/includes/loading_widget.dart';
import 'package:foodapp/models/user.dart';
import 'dart:io';

import 'package:foodapp/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


class AddReview extends StatefulWidget {
  final String? place_id;

  const AddReview({Key? key, this.place_id}) : super(key: key);
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController reviewController =TextEditingController();

  // TextEditingController priceController =TextEditingController();

  List<DocumentSnapshot> streetFoods = <DocumentSnapshot>[];
  bool loding  = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return loding ? Loading() : Scaffold(
      appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.close, color: Colors.black,)),
          title: Text('Add a Review', style: TextStyle(color: Colors.black),)
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[

            Text(widget.place_id!),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Enter a Review',textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 12,)),
            ),


            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: reviewController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: " Enter Review"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Add a review';
                  }
                },
              ),
            ),
            SizedBox(
              height: 0,
            ),
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Add Restaurant'),
              onPressed: () async {
                validatAndUpload(user!.uid);
              },
            )

          ],
        ),
      ),
    );
  }




  void validatAndUpload(String user_id) async {
    if(_formKey.currentState!.validate()) {
      setState(() {
        loding =true;
      });
      try{
        var id = Uuid();
        String reviewId = id.v1();

        print("adding street to database....");
        final CollectionReference reviewsCollection = Firestore.instance.collection("reviews");
        // await _dbservice.uploadStreetFood(placeNameController.text, imageUrl, locationController.text, vegeterianController.text, descriptionController.text);
        await reviewsCollection.document(reviewId).setData({
          'reviewID' : reviewId,
          'review' : reviewController.text,
          'postedBy' : user_id,
          'postedFor' : widget.place_id,

        }).then((value) => Navigator.pop(context));

      }catch(e){
        print("we had an error");
        print(e.toString());
      }
      setState(() {
        loding = false;
      });
      Fluttertoast.showToast(msg: "Review added");


  }

  }
}



