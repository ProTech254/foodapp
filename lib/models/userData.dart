class UserData{

  final String? user_id;
  final String? email;
  final String? firstname;
  final String? surname;
  final int? role;
  final String? password;

  UserData({this.user_id, this.email, this.firstname, this.surname, this.role, this.password});

  factory UserData.initialData() {
    return UserData(
      user_id: '',
      email: '',
      firstname: '',
      surname: '',
      role: null,
      password: '',

    );
  }


}