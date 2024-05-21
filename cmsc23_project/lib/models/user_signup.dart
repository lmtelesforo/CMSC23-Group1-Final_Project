import 'dart:convert';

class User {
  String name;
  String username;
  String password;
  String email;
  List addresses;
  String contactNumber;
  List? proofs;
  String? id;
  String userType;

  User ({
    this.id, 
    required this.name, 
    required this.username,
    required this.password,
    required this.email, 
    required this.addresses, 
    required this.contactNumber, 
    required this.userType,
    this.proofs 
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      addresses: json['addresses'],
      contactNumber: json['contactNumber'],
      userType: json['userType'],
      proofs: json['proofs']
    );
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(User User) {
    return {
      'id': User.id,
      'name': User.name,
      'username': User.username,
      'password': User.password,
      'email': User.email,
      'addresses': User.addresses,
      'contactNumber': User.contactNumber,
      'userType': User.userType,
      'proofs': User.proofs
    };
  }
}




