import 'dart:convert';

class User {
  String name;
  String username;
  String password;
  List addresses;
  String contactNumber;
  List? proofs;
  String? id;

  User ({
    this.id, 
    required this.name, 
    required this.username,
    required this.password, 
    required this.addresses, 
    required this.contactNumber, 
    this.proofs 
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      password: json['password'],
      addresses: json['addresses'],
      contactNumber: json['contactNumber'],
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
      'addresses': User.addresses,
      'contactNumber': User.contactNumber,
      'proofs': User.proofs
    };
  }
}




