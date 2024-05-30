import 'dart:convert';

class User {
  String name;
  String username;
  String email;
  List addresses;
  String contactNumber;
  String? id;
  String userType;

  User ({
    this.id, 
    required this.name, 
    required this.username,
    required this.email, 
    required this.addresses, 
    required this.contactNumber, 
    required this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      addresses: json['addresses'],
      contactNumber: json['contactNumber'],
      userType: json['userType'],
    );
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(User user) {
    return { // removed id mapping 
      'name': user.name,
      'username': user.username,
      'email': user.email,
      'addresses': user.addresses,
      'contactNumber': user.contactNumber,
      'userType': user.userType,
    };
  }
}




