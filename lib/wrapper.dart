import 'package:flutter/material.dart';
import 'package:foodapp/app_screens/home.dart';
import 'package:foodapp/app_screens/login.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print("user id");

    // Return home or authenticate widget
    if(user == null){
      return LoginPage();

    }else{
      return HomePage();
    }

  }
}
