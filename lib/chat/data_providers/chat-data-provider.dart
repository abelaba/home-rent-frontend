import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homerent/chat/models/ChatModel.dart';
import 'package:homerent/chat/models/MessageModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:homerent/auth/model/Auth.dart';
import 'package:http/http.dart' as http;

class ChatDataProvider {
  static final String _baseUrl = !kIsWeb? "http://10.0.2.2:3000/api/chat":"http://127.0.0.1:3000/api/chat";

  // * Create chat
  Future<ChatModel> create(ChatModel chatModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    if (token == null) {
      throw Exception("No token found");
    } else {
      final http.Response response = await http.post(
          Uri.parse("$_baseUrl/createChat"),
          headers: <String, String>{
            "Content-Type": "application/json",
            "auth-token": token
          },
          body: jsonEncode({
            "user2Id": chatModel.user2Id,
          }));

      if (response.statusCode == 201) {
        return ChatModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    }
  }

  //* send messages
  Future<ChatModel> sendMessage(MessageModel messageModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    if (token == null) {
      throw Exception("No token found");
    } else {
      final http.Response response = await http.put(
          Uri.parse("$_baseUrl/sendMessage"),
          headers: <String, String>{
            "Content-Type": "application/json",
            "auth-token": token
          },
          body: jsonEncode({
            "chatId": messageModel.chatId,
            "message": messageModel.message
          }));
      print("My response");
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.statusCode);
        return ChatModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    }
  }

  Future<List<MessageModel>> loadMessages(String chatId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    if (token == null) {
      throw Exception("No token found");
    } else {
      try {
        final response = await http.get(
            Uri.parse("$_baseUrl/loadMessages/$chatId"),
            headers: <String, String>{"auth-token": token});
        print("asjdkalsdkasdjljadlk");
        print(response.statusCode);
        if (response.statusCode == 200) {
          final messages = jsonDecode(response.body) as List;
          print(messages.map((c) => MessageModel.fromJson(c)).toList());
          return messages.map((c) => MessageModel.fromJson(c)).toList();
        } else {
          print("Could not load chats");
          throw Exception("Could not load chats");
        }
      } catch (e) {
        throw Exception("Error");
      }
    }
  }

  Future<List<ChatModel>> loadChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    if (token == null) {
      throw Exception("No token found");
    } else {
      try {
        final response = await http.get(Uri.parse("$_baseUrl/loadChats"),
            headers: <String, String>{"auth-token": token});
        print(response.statusCode);
        if (response.statusCode == 200) {
          final chats = jsonDecode(response.body) as List;
          var q = chats.map((c) => ChatModel.fromJson(c)).toList();
          return chats.map((c) => ChatModel.fromJson(c)).toList();
        } else {
          print("Could not load chats");
          throw Exception("Could not load chats");
        }
      } catch (e) {
        throw Exception("Error");
      }
    }
  }
}