class Rental {
  String? sId;
  bool? available;
  String? userId;
  String address;
  Object rentalImage;
  String? date;
  String type;
  int bedrooms;
  int bathrooms;
  int area;
  int price; // Added field

  Rental({
    this.sId,
    this.available,
    this.userId,
    required this.address,
    required this.rentalImage,
    this.date,
    required this.type,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.price, // Added parameter
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
      sId: json['_id'],
      available: json['available'],
      userId: json['userId'],
      address: json['address'],
      rentalImage: json['rentalImage'],
      date: json['date'],
      type: json['type'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      area: json['area'],
      price: json['price'], // Added field
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['available'] = this.available;
    data['userId'] = this.userId;
    data['address'] = this.address;
    data['rentalImage'] = this.rentalImage;
    data['date'] = this.date;
    data['type'] = this.type;
    data['bedrooms'] = this.bedrooms;
    data['bathrooms'] = this.bathrooms;
    data['area'] = this.area;
    data['price'] = this.price; // Added field
    return data;
  }
}
