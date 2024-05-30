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
  bool openForDonations;
  String? profilePic;
  String? about;

  Org(
      {this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.addresses,
      required this.contactNumber,
      required this.userType,
      required this.proofs,
      this.openForDonations = true,
      this.profilePic =
          'https://i.guim.co.uk/img/media/365305a402b261465a0105ea9f8b0c98478e6f42/0_448_6720_4032/master/6720.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=ec0bb7aed96eba1ca9fcebf4dbfffe82',
      this.about = ''});

  factory Org.fromJson(Map<String, dynamic> json) {
    return Org(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      addresses: json['addresses'],
      contactNumber: json['contactNumber'],
      userType: json['userType'],
      proofs: json['proofs'],
      openForDonations: json['openForDonations'],
      profilePic: json['profilePic'],
      about: json['about'],
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
      'proofs': org.proofs,
      'openForDonations': org.openForDonations,
      'profilePicture': org.profilePic
    };
  }
}
