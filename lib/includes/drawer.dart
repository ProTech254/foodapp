import 'package:flutter/material.dart';
import 'package:foodapp/app_screens/add_critic.dart';
import 'package:foodapp/app_screens/add_restaurant.dart';
import 'package:foodapp/app_screens/add_streetfood.dart';
import 'package:foodapp/app_screens/profile.dart';
import 'package:foodapp/models/userData.dart';
import 'package:foodapp/services/auth.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final AuthService _auth = AuthService();

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


    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 100,),
          role_admin ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Admin", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
          ): Text(user_data[0].firstname ?? "null", style:
            TextStyle(fontSize: 25, fontWeight: FontWeight.w800),),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Home'),
            onTap: () => {},
          ),
          role_admin ? ListTile(
            leading: Icon(Icons.input),
            title: Text('Add Restaurant'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddRestaurant()))
            },
          ): Text(""),

          role_admin ? ListTile(
            leading: Icon(Icons.input),
            title: Text('Add Critic'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCritic()))
            },
          ): Text(""),

          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Add Street Food'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddStreetFood()))
            },
          ),

          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile()))
            },
          ),


          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Forums'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async{

              await _auth.signOut();

            },
          ),
        ],
      ),
    );
  }
}