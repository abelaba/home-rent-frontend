class ChatModel {
  String? sId;
  String? user1Id;
  String? user2Id;
  String? user1Name;
  String? user2Name;
  List<dynamic>? messages;

  ChatModel(
      {this.user1Id,
      this.user2Id,
      this.user1Name,
      this.user2Name,
      this.messages,
      this.sId});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    print("hello");
    print(json['messages'].runtimeType);
    // List<String> tempmessages = [];
    // if (json['messages'] != null) {
    //   json['messages'].forEach((v) {
    //     tempmessages.add(v);
    //   });
    // }
    return ChatModel(
        sId: json['_id'],
        user1Id: json['user1Id'],
        user2Id: json['user2Id'],
        user1Name: json['user1Name'],
        user2Name: json['user2Name'],
        messages: json['messages']);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['user1Id'] = this.user1Id;
  //   data['user2Id'] = this.user2Id;
  //   if (this.messages != null) {
  //     data['messages'] = this.messages.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}