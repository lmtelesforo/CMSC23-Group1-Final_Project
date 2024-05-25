import 'dart:convert';

class Donations {
  String category;
  String shipping;
  String weight;
  List? photo;
  String date;
  String time;
  List addresses;
  String contactNumber;
  String? qrcode;
  String status;
  String? id;

  Donations ({
    this.id, 
    required this.category, 
    required this.shipping,
    required this.weight,
    required this.date, 
    required this.time,
    required this.addresses, 
    required this.contactNumber, 
    required this.status,
    this.qrcode,
    this.photo
  });

  factory Donations.fromJson(Map<String, dynamic> json) {
    return Donations(
      id: json['id'],
      category: json['category'],
      shipping: json['shipping'],
      weight: json['weight'],
      date: json['date'],
      time: json['time'],
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
      'weight': Donation.weight,
      'shipping': Donation.shipping,
      'date': Donation.date,
      'time': Donation.time,
      'addresses': Donation.addresses,
      'contactNumber': Donation.contactNumber,
      'photo': Donation.photo,
      'status': Donation.status,
      'qrcode': Donation.qrcode
    };
  }
}




