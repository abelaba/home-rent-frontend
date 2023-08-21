class MessageModel {
  String? chatId;
  String? senderName;
  String? senderEmail; // New field
  String? message;
  String? time;

  MessageModel({this.chatId, this.senderName, this.senderEmail, this.message, this.time});

  MessageModel.fromJson(Map<String, dynamic> json) {
    chatId = json['_id'];
    senderName = json['senderName'];
    senderEmail = json['senderEmail']; // Assign the new field
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatId'] = this.chatId;
    data['senderName'] = this.senderName;
    data['senderEmail'] = this.senderEmail; // Add the new field
    data['message'] = this.message;
    data['time'] = this.time;
    return data;
  }
}
