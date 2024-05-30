import 'dart:convert';

class Donations {
  List category;
  String shipping;
  String weight;
  List? photo;
  List? imageUrls;
  List? addresses;
  String? contactNumber;
  String? qrcode;
  String status;
  String? id;
  String email;
  String name;
  // DateTime dateTime;
  String date;
  String time;

  Donations ({
    this.id, 
    required this.category, 
    required this.shipping,
    required this.weight,
    this.addresses, 
    this.contactNumber, 
    required this.status,
    required this.name,
    required this.email,
    // required this.dateTime,
    required this.date,
    required this.time,
    this.qrcode,
    this.photo,
    this.imageUrls,
  });

  factory Donations.fromJson(Map<String, dynamic> json) {
    return Donations(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      category: json['category'],
      shipping: json['shipping'],
      weight: json['weight'],
      // dateTime: json['dateTime'],
      date: json['date'],
      time: json['time'],
      addresses: json['addresses'],
      contactNumber: json['contactNumber'],
      photo: json['photo'],
      imageUrls: json['imageUrls'],
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
      'imageUrls': Donation.imageUrls,
      'status': Donation.status,
      'qrcode': Donation.qrcode
    };
  }
}




