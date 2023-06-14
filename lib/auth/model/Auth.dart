class Authentication {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? date;

  Authentication(
      {this.sId,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.date});

  factory Authentication.fromJson(Map<String, dynamic> json) {
    return Authentication(
        sId: json['_id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        phoneNumber: json['phoneNumber'],
        date: json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['date'] = this.date;
    return data;
  }
}