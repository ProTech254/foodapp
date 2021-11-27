import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodapp/models/restaurantData.dart';
import 'package:foodapp/models/reviewsData.dart';
import 'package:foodapp/models/streetfoodData.dart';
import 'package:foodapp/models/userData.dart';

class DatabaseService{
   // collection reference
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection = Firestore.instance.collection("users");
  final CollectionReference restaurantCollection = Firestore.instance.collection("restaurants");
  final CollectionReference streetfoodCollection = Firestore.instance.collection("streetfoods");

  Future updateUserData (String firstname, String surname, String email, int role, String password) async {
    return await userCollection.document(uid).setData({
      "user_id" : uid,
      "firstname" : firstname,
      "surname" : surname,
      "email" : email,
      "role" : role,
      "password": password,
    });
  }

  // User list from snapshot


  List<UserData>_userListFromSnapsht(QuerySnapshot snapshot){

    return snapshot.documents.map((doc){

      return UserData(
        user_id: doc.data['user_id'] ?? uid,
        email: doc.data['email'] ?? null,
        firstname: doc.data['firstname'] ?? null,
        surname: doc.data['surname'] ?? null,
        role: doc.data['role'] ?? null,
        password: doc['data'] ?? null,
      );
    }).toList();
  }

  Stream<List<UserData>> usersById(String user_id){

    return Firestore.instance.collection('users').where("user_id", isEqualTo: user_id).snapshots()
        .map(_userListFromSnapsht);
  }

  // Upload a restaurant

  void uploadRestaurant(String restaurantName, String description, String image){
    restaurantCollection.document().setData({
      'restaurantID' : "nsk",
      'restaurantName' : restaurantName,
      'description' : description,
      'image' : image,
    });
  }

  List<restaurantData> restaurantListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
//      print(doc.data['images']);
      return restaurantData(
        // restaurantID: doc.data['id'],
        restaurantID : doc.data['restaurantID'],
        restaurantName : doc.data['restaurantName'],
        description: doc.data['description'],
        image : doc.data['image'],
      );
    }).toList();

  }

  // get restaurants data using streams

  Stream<List<restaurantData>> get restaurants {
    return restaurantCollection.snapshots()
        .map(restaurantListFromSnapshot);
  }
  Stream<List<restaurantData>>  restaurantById(String restaurant_id) {
    return  Firestore.instance.collection('restaurants').where("restaurantID", isEqualTo: restaurant_id).snapshots()
        .map(restaurantListFromSnapshot);
  }

  // Street food data


  void uploadStreetFood(String placeName, String postedBy, String picture, String location, String vegeterian_status, String description){
    streetfoodCollection.document().setData({
      'placeID' : "nsk",
      'placeName' : placeName,
      'location' : location,
      'vegeterian_status' : vegeterian_status,
      'description' : description,
      'picture' : picture,
      'postedBy': postedBy
    });
  }

  List<streetFoodData> streetfoodListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
//      print(doc.data['images']);
      return streetFoodData(
        // restaurantID: doc.data['id'],
        placeID: doc.data['placeID'],
        placeName : doc.data['placeName'],
        location: doc.data['location'],
        vegeterian_status : doc.data['vegeterian_status'],
        description : doc.data['description'],
        image : doc.data['picture'],
        postedBy: doc.data['postedBy']


      );
    }).toList();

  }

  // get restaurants data using streams

  Stream<List<streetFoodData>> get streetfoods {
    return streetfoodCollection.snapshots()
        .map(streetfoodListFromSnapshot);
  }
  Stream<List<streetFoodData>>  placeById(String place_id) {
    return  Firestore.instance.collection('streetFoods').where("placeID", isEqualTo: place_id).snapshots()
        .map(streetfoodListFromSnapshot);
  }
//


//Reviews data
  List<reviewsData> reviewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
//      print(doc.data['images']);
      return reviewsData(
          review: doc.data['review'],
          reviewID: doc.data['reviewID'],
          postedBy: doc.data['postedBy'],
          postedFor: doc.data['postedFor'],
      );
    }).toList();
  }

  // get restaurants data using streams

  Stream<List<reviewsData>> get reviews {
    return streetfoodCollection.snapshots()
        .map(reviewListFromSnapshot);
  }

}