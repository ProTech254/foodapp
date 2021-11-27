

class MyUser {
  final String uid;

  MyUser({required this.uid});

  factory MyUser.initialData() {
    return MyUser(
      uid: '',

    );
  }

}