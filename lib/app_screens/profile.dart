

import 'package:flutter/material.dart';
import 'package:foodapp/includes/userProfileWidget.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/models/userData.dart';
import 'package:foodapp/services/database.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<UserData>>.value(
          value:DatabaseService().usersById(user!.uid),
          initialData: [],
        ),

      ],
      child: Scaffold(
        body: SingleChildScrollView(
            child: UserProfileWidget()
        ),
      ),

    );
  }
}
