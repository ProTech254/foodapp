
import 'package:flutter/material.dart';
import 'package:foodapp/app_screens/chats.dart';
import 'package:foodapp/includes/productTile.dart';
import 'package:foodapp/includes/streetfoodTile.dart';
import 'package:foodapp/models/forumsData.dart';
import 'package:foodapp/models/restaurantData.dart';
import 'package:foodapp/models/streetfoodData.dart';
import 'package:provider/provider.dart';


class ForumList extends StatefulWidget {
  @override
  _ForumListState createState() => _ForumListState();
}

class _ForumListState extends State<ForumList> {
  @override
  Widget build(BuildContext context) {
    final forumlist = Provider.of<List<ForumData>>(context);
    if(forumlist.length == 0){
      return Center(child: Text('Oops!!,No forums added '));
    }else {
      print("Forum list");
      print(forumlist.length);
      return ListView.builder(
          itemCount: forumlist.length,
          itemBuilder: (context, index){
            return Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chats(topic_id: forumlist[index].topicID, topic_name: forumlist[index].topic,)));
                },

                child: ListTile(

                  title: Text(forumlist[index].topic ?? ""),
                  subtitle: Text("Posted by Admin"),
                ),
              ),
            );

          }

      );
    }

  }
}
