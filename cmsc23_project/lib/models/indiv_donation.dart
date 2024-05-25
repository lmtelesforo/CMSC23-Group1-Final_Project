import 'dart:convert';

class Donations {
  List category;
  String shipping;
  String weight;
  List? photo;
  List addresses;
  String contactNumber;
  String? qrcode;
  String status;
  String? id;
  String name;
  DateTime dateTime;

  Donations ({
    this.id, 
    required this.category, 
    required this.shipping,
    required this.weight,
    required this.addresses, 
    required this.contactNumber, 
    required this.status,
    required this.name,
    required this.dateTime,
    this.qrcode,
    this.photo
  });

  factory Donations.fromJson(Map<String, dynamic> json) {
    return Donations(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      shipping: json['shipping'],
      weight: json['weight'],
      dateTime: json['datetime'],
      addresses: json['addresses'],
      contactNumber: json['contactNumber'],
      photo: json['photo'],
      qrcode: json['qrcode'],
      status: json['status']
    );
  }

  static List<Donations> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donations>((dynamic d) => Donations.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donations Donation) {
    return {
      'id': Donation.id,
      'category': Donation.category,
      'name': Donation.name,
      'weight': Donation.weight,
      'shipping': Donation.shipping,
      'addresses': Donation.addresses,
      'contactNumber': Donation.contactNumber,
      'photo': Donation.photo,
      'status': Donation.status,
      'qrcode': Donation.qrcode
    };
  }
}




