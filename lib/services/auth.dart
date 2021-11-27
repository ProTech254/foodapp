import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/services/database.dart';

class AuthService {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // create user based on firebase object
    MyUser? _userFromFirebaseUser(FirebaseUser user){
        return user != null ? MyUser(
            uid: user.uid
        ): null;
    }

    //auth change user stream
    Stream<MyUser?> get user{
        return _auth.onAuthStateChanged
            .map(_userFromFirebaseUser);
    }

    Future signInAnon() async {
        try {
            AuthResult result = await _auth.signInAnonymously();
            FirebaseUser user = result.user;
            return _userFromFirebaseUser(user);
        }catch(e){
            print(e.toString());
            print(e.toString());
            return null;
        }
    }

    // Register with email and password
    Future registerWithEmailAndPassword(String email,String firstname, String surname, int role,  String password) async {
        try{
            AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
            FirebaseUser user= result.user;

            // create a new document for the user with the uid
            await DatabaseService(uid: user.uid).updateUserData(firstname, surname, email, role, password);
            return _userFromFirebaseUser(user);
        }catch(e){
            print(e.toString());
            return null;
        }
    }


    // Sign in with email and password
    Future signInWithEmailAndPassword(String email, String password) async {

        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);

    }

    // Sign Out
    Future signOut() async {
        try {
            return await _auth.signOut();
        } catch (e) {
            print(e.toString());
            return null;
        }
    }
}