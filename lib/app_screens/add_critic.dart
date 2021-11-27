

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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


class AddCritic extends StatefulWidget {


  @override
  _AddCriticState createState() => _AddCriticState();
}

class _AddCriticState extends State<AddCritic> {


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController =TextEditingController();
  TextEditingController firstController =TextEditingController();
  TextEditingController surnameController =TextEditingController();

  TextEditingController passwordController =TextEditingController();

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
          title: Text('Add a Critic', style: TextStyle(color: Colors.black),)
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[


            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Enter email',textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 12,)),
            ),


            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: " Enter email"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Add an email';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: firstController,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: " Enter first name"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Add a first name';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: surnameController,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: " Enter surname"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Add a surname name';
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: " Enter password"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Add a password';
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
              child: Text('Add Critic'),
              onPressed: () async {
                final FirebaseAuth _auth = FirebaseAuth.instance;
                try{
                  AuthResult result = await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);

                  FirebaseUser user_added= result.user;
                  // create a new document for the user with the uid
                  await DatabaseService(uid: user_added.uid).updateUserData(firstController.text, surnameController.text, emailController.text, 0, passwordController.text);

                }catch(e){
                  print(e.toString());
                  return null;
                }
              },
            )

          ],
        ),
      ),
    );
  }

}



