import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/userData.dart';

import 'package:provider/provider.dart';

class UserProfileWidget extends StatefulWidget {
  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool firstname_editing = false;
  bool surnamename_editing = false;
  bool email_editing = false;
  bool password_editing = false;

  final _firstnameform_key = GlobalKey<FormState>();
  final _surnameform_key = GlobalKey<FormState>();
  final _emailform_key = GlobalKey<FormState>();
  final _passwordform_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    int succesful_orders;
    final user_data = Provider.of<List<UserData>>(context);


    return  Stack(
      children: <Widget>[
        SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.asset('assets/images/profile.png')
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 96.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                               Row(
                                children: <Widget>[
                                  Text(
                                    user_data[0].firstname ?? 'No name',
                                    style: Theme.of(context).textTheme.title,
                                  ),

                                ],
                              ),

                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(user_data[0].email!),
//                                subtitle: Text("Kathmandu"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),

                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/profile.png',),fit: BoxFit.cover)),
                    margin: EdgeInsets.only(left: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Your information"),

                    ),
                    Divider(),
                    !firstname_editing ? ListTile(
                      title: Text("Firstname"),
                      subtitle: Text(user_data[0].firstname!),
                      leading: Icon(Icons.email, color: Colors.redAccent,),
                      trailing: IconButton(
                        onPressed: (){
                          setState(() {
                            firstname_editing = true;
                            firstnameController.text = user_data[0].firstname!;
                          });
                        },
                        icon: Icon(Icons.edit, color: Colors.deepOrangeAccent,),),
                    ):
                    Form(
                      key: _firstnameform_key,
                      child: Container(
                        width: 280,
                        child: Stack(

                          children: <Widget>[
                            Container(
                              width: 240,
                              child: TextFormField(

                                controller: firstnameController,
                                keyboardType: TextInputType.text,
                                validator: (name){
                                  print('you have printed ${name}');
                                  if(name!.isEmpty){
                                    return 'Your firstname cannot be empty';
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "Firstname"
                                ),
                              ),
                            ),
                            Positioned(

                              right: 1,
                              child: IconButton(
                                onPressed: (){
                                  if(_firstnameform_key.currentState!.validate()){
                                    final Query user_list = Firestore.instance
                                        .collection('users').where("user_id", isEqualTo: user_data[0].user_id);
                                    user_list.getDocuments().then((snaps){
                                      print(snaps.documents.length);
                                      final String id_doc = snaps.documents[0].documentID;
                                      Firestore.instance.collection("users").document(id_doc).updateData({
                                        "firstname": firstnameController.text,

                                      });
                                    });
                                    setState(() {
                                      firstname_editing= false;
                                    });
                                  }

                                },
                                icon: Icon(Icons.check),tooltip: 'Update',color: Colors.green,),
                            )
                          ],
                        ),
                      ),

                    ),
                    !surnamename_editing ? ListTile(
                      title: Text("Surname"),
                      subtitle: Text(user_data[0].surname!),
                      leading: Icon(Icons.email, color: Colors.redAccent,),
                      trailing: IconButton(
                        onPressed: (){
                          setState(() {
                            surnamename_editing = true;
                            surnameController.text = user_data[0].surname!;
                          });
                        },
                        icon: Icon(Icons.edit, color: Colors.deepOrangeAccent,),),
                    ):
                    Form(
                      key: _surnameform_key,
                      child: Container(
                        width: 280,
                        child: Stack(

                          children: <Widget>[
                            Container(
                              width: 240,
                              child: TextFormField(

                                controller: surnameController,
                                keyboardType: TextInputType.text,
                                validator: (name){
                                  print('you have printed ${name}');
                                  if(name!.isEmpty){
                                    return 'Your password cannot be empty';
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "Surname"
                                ),
                              ),
                            ),
                            Positioned(

                              right: 1,
                              child: IconButton(
                                onPressed: (){
                                  if(_surnameform_key.currentState!.validate()){
                                    final Query user_list = Firestore.instance
                                        .collection('users').where("user_id", isEqualTo: user_data[0].user_id);
                                    user_list.getDocuments().then((snaps){
                                      print(snaps.documents.length);
                                      final String id_doc = snaps.documents[0].documentID;
                                      Firestore.instance.collection("users").document(id_doc).updateData({
                                        "surname": surnameController.text,
                                      });
                                    });
                                    setState(() {
                                      surnamename_editing= false;
                                    });
                                  }

                                },
                                icon: Icon(Icons.check),tooltip: 'Update',color: Colors.green,),
                            )
                          ],
                        ),
                      ),

                    ),

                    //email editing

                    !email_editing ? ListTile(
                      title: Text("Email"),
                      subtitle: Text(user_data[0].email!),
                      leading: Icon(Icons.email, color: Colors.redAccent,),
                      trailing: IconButton(
                        onPressed: (){
                          setState(() {
                            email_editing = true;
                            emailController.text = user_data[0].email!;
                          });
                        },
                        icon: Icon(Icons.edit, color: Colors.deepOrangeAccent,),),
                    ):
                    Form(
                      key: _emailform_key,
                      child: Container(
                        width: 280,
                        child: Stack(

                          children: <Widget>[
                            Container(
                              width: 240,
                              child: TextFormField(

                                controller: emailController,
                                keyboardType: TextInputType.text,
                                validator: (name){
                                  print('you have printed ${name}');
                                  if(name!.isEmpty){
                                    return 'Your email cannot be empty';
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "Email"
                                ),
                              ),
                            ),
                            Positioned(

                              right: 1,
                              child: IconButton(
                                onPressed: (){
                                  if(_emailform_key.currentState!.validate()){
                                    final Query user_list = Firestore.instance
                                        .collection('users').where("user_id", isEqualTo: user_data[0].user_id);
                                    user_list.getDocuments().then((snaps){
                                      print(snaps.documents.length);
                                      final String id_doc = snaps.documents[0].documentID;
                                      Firestore.instance.collection("users").document(id_doc).updateData({
                                        "email": emailController.text,

                                      });
                                    });
                                    setState(() {
                                      email_editing= false;
                                    });
                                  }

                                },
                                icon: Icon(Icons.check),tooltip: 'Update',color: Colors.green,),
                            )
                          ],
                        ),
                      ),

                    ),



                  ],
                ),
              )
            ],
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
      ],
    );
  }
}
