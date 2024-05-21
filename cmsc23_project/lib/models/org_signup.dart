import 'dart:convert';

class Org {
  String name;
  String username;
  String password;
  String email;
  List addresses;
  String contactNumber;
  List proofs;
  String? id;
  String userType;

  Org ({
    this.id, 
    required this.name, 
    required this.username,
    required this.password,
    required this.email, 
    required this.addresses, 
    required this.contactNumber, 
    required this.userType,
    required this.proofs 
  });

  factory Org.fromJson(Map<String, dynamic> json) {
    return Org(
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

  static List<Org> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Org>((dynamic d) => Org.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Org Org) {
    return {
      'id': Org.id,
      'name': Org.name,
      'username': Org.username,
      'password': Org.password,
      'email': Org.email,
      'addresses': Org.addresses,
      'contactNumber': Org.contactNumber,
      'userType': Org.userType,
      'proofs': Org.proofs
    };
  }
}




