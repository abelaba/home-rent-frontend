import 'package:flutter/material.dart';
import 'package:homerent/auth/data-provider/auth-data-provider.dart';
import 'package:homerent/chat/data_providers/chat-data-provider.dart';
import 'package:homerent/chat/models/ChatModel.dart';
import 'package:homerent/chat/models/MessageModel.dart';

class ChatRepository {
  final ChatDataProvider dataProvider;
  ChatRepository({required this.dataProvider});
  Future<ChatModel> create(ChatModel chatModel) async {
    return this.dataProvider.create(chatModel);
  }

  Future<List<ChatModel>> loadChats() async {
    print("LOad chats called repository");
    return this.dataProvider.loadChats();
  }

  Future<List<MessageModel>> loadMessages(String chatId) async {
    print("LOad messages called repository");
    return this.dataProvider.loadMessages(chatId);
  }

  Future<ChatModel> sendMessage(MessageModel messageModel) async {
    print("LOad chats called repository");
    return this.dataProvider.sendMessage(messageModel);
  }
}