import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/includes/chatList.dart';
import 'package:foodapp/models/chatData.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/models/userData.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';

class Chats extends StatefulWidget {
  final String? topic_id;
  final String? topic_name;
  const Chats({Key? key, this.topic_id, this.topic_name}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController messageController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<ChatData>>.value(
          initialData: [],
          value: DatabaseService().chatById(widget.topic_id!),
        ),

      ],
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: SafeArea(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back,color: Colors.black,),
                        ),
                        SizedBox(width: 2,),
                        CircleAvatar(

                          maxRadius: 20,
                        ),
                        SizedBox(width: 12,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(widget.topic_name!,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                              SizedBox(height: 6,),
                              Text("By Admin",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),

                ],

              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[

                      SizedBox(width: 15,),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: messageController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 6,
                            decoration: InputDecoration(
                                hintText: "Write something on the forum...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Add a message';
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      FloatingActionButton(
                        onPressed: () async{
                          try{


                            print("adding forum to database....");
                            final CollectionReference chatCollection = Firestore.instance.collection("chats");
                            // await _dbservice.uploadStreetFood(placeNameController.text, imageUrl, locationController.text, vegeterianController.text, descriptionController.text);
                            await chatCollection.document().setData({
                              'chat' : messageController.text,
                              'postedBy' : user!.uid,
                              'topicID' : widget.topic_id,
                              'datePosted' : DateTime.now()
                            }).then((value) {
                              messageController.clear();
                              Fluttertoast.showToast(msg: "Message Added");
                            });

                          }catch(e){
                            print("we had an error");
                            print(e.toString());
                          }
                        },
                        child: Icon(Icons.send,color: Colors.white,size: 18,),
                        backgroundColor: Colors.blue,
                        elevation: 0,
                      ),
                    ],

                  ),
                ),
              ),
              ChatList()
            ],
          ),
      ),
    );
  }
}
