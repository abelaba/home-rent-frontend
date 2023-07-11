class MessageModel {
  String? chatId;
  String? senderName;
  String? message;
  String? time;

  MessageModel({this.chatId, this.senderName, this.message, this.time});

  MessageModel.fromJson(Map<String, dynamic> json) {
    chatId = json['_id'];
    senderName = json['senderName'];
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatId'] = this.chatId;
    data['senderName'] = this.senderName;
    data['message'] = this.message;
    data['time'] = this.time;
    return data;
  }
}