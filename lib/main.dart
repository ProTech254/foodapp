import 'package:flutter/material.dart';
import 'package:foodapp/app_screens/splash_screen.dart';
import 'package:foodapp/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
// @dart=2.9

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(

        value: AuthService().user,
        initialData: MyUser.initialData(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.redAccent
        ),
        home: SplashScreen(),
      ),
    );
  }
}

