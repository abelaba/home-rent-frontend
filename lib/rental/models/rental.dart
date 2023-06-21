import 'package:flutter/cupertino.dart';

class Rental {
  String? sId;
  bool? available;
  String? userId;
  String address;
  Object rentalImage;
  String? date;

  Rental(
      {this.sId,
      this.available,
      this.userId,
      required this.address,
      required this.rentalImage,
      this.date});

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
        sId: json['_id'],
        available: json['available'],
        userId: json['userId'],
        address: json['address'],
        rentalImage: json['rentalImage'],
        date: json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['available'] = this.available;
    data['userId'] = this.userId;
    data['address'] = this.address;
    data['rentalImage'] = this.rentalImage;
    data['date'] = this.date;
    return data;
  }
}