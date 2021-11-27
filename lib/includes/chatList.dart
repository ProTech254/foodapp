import 'package:flutter/material.dart';
import 'package:foodapp/models/chatData.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/models/userData.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    final chatlist = Provider.of<List<ChatData>>(context);
    final user = Provider.of<MyUser?>(context);
    if(chatlist.length == 0){
      return Center(child: Text("There are no conversations in this forum.\n Start below"));
    }else{
      return ListView.builder(
        itemCount: chatlist.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10,bottom: 10),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return Container(
            padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
            child: Align(
              alignment: (chatlist[index].postedBy == user!.uid?Alignment.topRight:Alignment.topLeft),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (chatlist[index].postedBy == user.uid?Colors.grey.shade200:Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(chatlist[index].chat!, style: TextStyle(fontSize: 15),),
                  ),
                  // Text(chatlist[index].datePosted.toDate().toDa, style: TextStyle(fontSize: 13, color: Colors.grey))
                ],
              ),
            ),
          );
        },
      );
    }

  }
}
