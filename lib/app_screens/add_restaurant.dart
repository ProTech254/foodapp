

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/includes/loading_widget.dart';
import 'dart:io';

import 'package:foodapp/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';


class AddRestaurant extends StatefulWidget {
  @override
  _AddRestaurantState createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {

  
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController restaurantNameController =TextEditingController();
  TextEditingController descriptionController =TextEditingController();
  // TextEditingController priceController =TextEditingController();
  
  List<DocumentSnapshot> restaurants = <DocumentSnapshot>[];
  
 
  bool loding = false;
  String imageError = '';
  List images  = [];
  File? _image = null;
 

  final picker = ImagePicker();

 
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      images.add(_image);
      print(_image);
    });
  }
  @override
  Widget build(BuildContext context) {
    return loding ? Loading() : Scaffold(
      appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.close, color: Colors.black,)),
          title: Text('Add restaurant', style: TextStyle(color: Colors.black),)
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _image != null ?  Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 40, 14.0, 40),
                      child: Image.file(_image!, fit: BoxFit.contain),
                    ): OutlineButton(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.8), width: 1.0),
                      onPressed: (){
                        getImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 40, 14.0, 40),
                        child: Icon(Icons.add, color: Colors.grey,),
                      ),

                    ),
                  ),
                ),
               


              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(imageError, style: TextStyle(color: Colors.red, fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Enter a restaurant name',textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 12,)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: restaurantNameController,
                decoration: InputDecoration(
                    hintText: "Add restaurant name"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Add a restaurant name';
                  }else if(value.length > 30){
                    return "Restaurant name cant be more than 15 letters";
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: "Description"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Add Description';
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
                validatAndUpload();
              },
            )

          ],
        ),
      ),
    );
  }

 


  void validatAndUpload() async {
    if(_formKey.currentState!.validate()) {
      setState(() {
        loding =true;
      });
      if(_image != null){
        String imageUrl;
        final DatabaseService _dbservice = DatabaseService();
        final FirebaseStorage storage = FirebaseStorage.instance;

        final String pictures= "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task = storage.ref().child(pictures).putFile(_image);
       
      

        StorageTaskSnapshot snapshot = await task.onComplete.then((snapshot) => snapshot);
       

        task.onComplete.then((snapshot) async {
          imageUrl = await snapshot.ref.getDownloadURL();
          try{
            var id = Uuid();
            String resId = id.v1();
            print("adding products to database....");
            // await _dbservice.uploadRestaurant(restaurantNameController.text, descriptionController.text, imageUrl);
            final CollectionReference restaurantCollection = Firestore.instance.collection("restaurants");
            restaurantCollection.document(resId).setData({
              'restaurantID' : "nsk",
              'restaurantName' : restaurantNameController.text,
              'description' : descriptionController.text,
              'image' : imageUrl,
            });

          }catch(e){
            print("we had an error");
            print(e.toString());
          }
          setState(() {
            loding = false;
          });
          Fluttertoast.showToast(msg: "Restaurant added");
        });

      }else{
        Fluttertoast.showToast(msg: "Upload atleast 3images");
        imageError = 'Upload atleast 3 images';
      }
    }

  }
}



