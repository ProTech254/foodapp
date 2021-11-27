import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/app_screens/register.dart';
import 'package:foodapp/services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  // Text field states

  String email = '';
  String password = '';
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/3.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff6bceff),
                      Color(0xff6bceff)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90)
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.person,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 32,
                          right: 32
                      ),
                      child: Text('Foodie App',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 45,
                      padding: EdgeInsets.only(
                          top: 4,left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(50)
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5
                            )
                          ]
                      ),
                      child: TextFormField(
                        validator: (val) => val!.isEmpty ? 'Empty email' : null,
                        onChanged: (val){
                            setState(() {
                              email = val;
                            });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.person,
                            color: Color(0xff6bceff),
                          ),
                          hintText: 'Email',
                        ),
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 45,
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.only(
                          top: 4,left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(50)
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5
                            )
                          ]
                      ),
                      child: TextFormField(
                        validator: (val) => val!.isEmpty ? "Password is empty" : null,
                        onChanged: (val){
                            setState(() {
                              password = val;
                            });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.vpn_key,
                            color: Color(0xff6bceff),
                          ),
                          hintText: 'Password',
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16, right: 32
                        ),
                        child: Text('Forgot Password ?',
                          style: TextStyle(
                              color: Colors.grey
                          ),
                        ),
                      ),
                    ),
                    Spacer(),

                    InkWell(
                      onTap: () async{

                        if(_formkey.currentState!.validate()){
                          print(email);
                          print(password);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        }
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width/1.2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.orangeAccent,
                                Colors.deepOrange
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(50)
                            )
                        ),
                        child: Center(
                          child: Text('Login'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Not a member ?"),

              ],
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage()));

              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width/1.2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orangeAccent,
                        Colors.deepOrange
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(50)
                    )
                ),
                child: Center(
                  child: Text('Register'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}