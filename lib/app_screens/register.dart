import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/app_screens/home.dart';
import 'package:foodapp/services/auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  String email = '';
  String firstname = '';
  String surname = '';
  String password = '';
  String confirm_password = '';
  String error = '';

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

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
                    child:
                    Icon(Icons.person,
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
                      child: Text('Sign Up',
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
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
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
                            firstname = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'FirstName',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
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
                          validator: (val) => val!.isEmpty ? 'Empty Surname' : null,
                        onChanged: (val){
                          setState(() {
                            surname = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Surname',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
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
                        validator: (val) => val!.length < 6 ? 'Empty password' : null,
                        onChanged: (val){
                          setState(() {
                            password = val;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
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
                          validator: (val) => val != password ? 'Passwords did not match' : null,
                        onChanged: (val){
                          setState(() {
                            confirm_password = val;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () async{
                        if(_formkey.currentState!.validate()){
                          print(email);
                          print(password);

                          dynamic result = await _auth.registerWithEmailAndPassword(email, firstname, surname, 2, password);


                          if(result == null){
                            setState(() {
                              error = "An error has occured registering";
                            });
                          }else{
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                          }
                        }

                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width/1.2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff6bceff),
                                Color(0xFF00abff),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(50)
                            )
                        ),
                        child: Center(
                          child: Text('Sign Up'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                  Text(error, style: TextStyle(color: Colors.red, fontSize: 14))
                  ],
                ),
              ),
            ),

            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Have an account ?"),
                  Text("Login",style: TextStyle(color: Color(0xff6bceff)),),
                ],
              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],

        ),
      ),
    );
  }
}