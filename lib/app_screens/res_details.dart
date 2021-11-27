import 'package:flutter/material.dart';
import 'package:foodapp/includes/resDeatailWidget.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/models/userData.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';

class ResDetails extends StatefulWidget {
  final String? res_name;
  final String? res_id;
  final String? res_description;
  final String? image;

  const ResDetails({Key? key, this.res_name, this.res_id, this.res_description, this.image}) : super(key: key);


  @override
  _ResDetailsState createState() => _ResDetailsState();
}

class _ResDetailsState extends State<ResDetails> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<UserData>>.value(
          value: DatabaseService().usersById(user!.uid),
          initialData: [],
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.redAccent,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.close, color: Colors.white,)),
        ),
        body: ResdetailWidget(res_name: widget.res_name, res_id: widget.res_id, res_description: widget.res_description, image: widget.image,)
      ),
    );
  }
}
