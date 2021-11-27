

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


class AddForum extends StatefulWidget {
  @override
  _AddForumState createState() => _AddForumState();
}

class _AddForumState extends State<AddForum> {


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController forumController =TextEditingController();

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
          title: Text('Add a Forum', style: TextStyle(color: Colors.black),)
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Enter a Forum Topic',textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 12,)),
            ),


            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: forumController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: " Enter Forum Topic"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Add a forum topic';
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
              child: Text('Add Forum'),
              onPressed: () async {
                try{
                  var id = Uuid();
                  String forumId = id.v1();

                  print("adding forum to database....");
                  final CollectionReference forumCollection = Firestore.instance.collection("forums");
                  // await _dbservice.uploadStreetFood(placeNameController.text, imageUrl, locationController.text, vegeterianController.text, descriptionController.text);
                  await forumCollection.document(forumId).setData({
                    'topicID' : forumId,
                    'topic_name' : forumController.text,
                  }).then((value) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "Forum added");
                  });

                }catch(e){
                  print("we had an error");
                  print(e.toString());
                }
              },
            )

          ],
        ),
      ),
    );
  }

}



