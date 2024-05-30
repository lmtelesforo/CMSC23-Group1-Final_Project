import 'dart:convert';

class Org {
  String name;
  String username;
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

  Map<String, dynamic> toJson(Org org) {
    return {
      'name': org.name,
      'username': org.username,
      'email': org.email,
      'addresses': org.addresses,
      'contactNumber': org.contactNumber,
      'userType': org.userType,
      'proofs': org.proofs
    };
  }
}




