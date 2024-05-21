import 'dart:convert';

class Donation {
  String category;
  String shipping;
  String weight;
  String date;
  String time;
  List addresses;
  String contactNumber;
  String? id;

  Donation ({
    this.id, 
    required this.category, 
    required this.shipping,
    required this.weight,
    required this.date, 
    required this.time,
    required this.addresses, 
    required this.contactNumber, 
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      category: json['category'],
      shipping: json['shipping'],
      weight: json['weight'],
      date: json['date'],
      time: json['time'],
      addresses: json['addresses'],
      contactNumber: json['contactNumber']
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation Donation) {
    return {
      'id': Donation.id,
      'category': Donation.category,
      'weight': Donation.weight,
      'shipping': Donation.shipping,
      'date': Donation.date,
      'time': Donation.time,
      'addresses': Donation.addresses,
      'contactNumber': Donation.contactNumber
    };
  }
}




