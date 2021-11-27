import "package:flutter/material.dart";
import 'package:foodapp/app_screens/login.dart';
import 'package:foodapp/services/auth.dart';
import 'package:foodapp/wrapper.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

          children: <Widget>[
            Container(

            decoration: BoxDecoration(
                image: DecorationImage(
                image: AssetImage('assets/images/food.jpg'),
              fit: BoxFit.cover
                ) ,
              )),
            Container(
              alignment: Alignment.center,
                child: Text("Welcome to For Foodies By Foodied", style: TextStyle(fontSize: 35, color:Colors.white),
                )),

            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(10),
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                onPressed: () async{
                  // dynamic result = await _auth.signInAnon();
                  // if(result == null){
                  //   print("error in sign in");
                  // }else{
                  //   print("signed in");
                  //   print(result.uid);
                  // }
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wrapper()));


                },
                padding: EdgeInsets.all(10.0),
                color: Colors.deepOrange,
                textColor: Colors.white,

                child: Text("Get Started",
                    style: TextStyle(fontSize: 15)),
              ),
            ),
          ]
      ),
    );
  }
}
