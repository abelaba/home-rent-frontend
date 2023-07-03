import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:homerent/auth/model/Auth.dart';
import 'package:http/http.dart' as http;

class AuthenticationDataProvider {
  static final String _baseUrl = "http://10.0.2.2:3000/api/user";
  // static final String _baseUrl = "http://127.0.0.1:3000/api/user";

  // * SIGN UP
  Future<Authentication> register(Authentication authentication) async {
    final http.Response response =
        await http.post(Uri.parse("$_baseUrl/register"),
            headers: <String, String>{
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "name": authentication.name,
              "email": authentication.email,
              "phoneNumber": authentication.phoneNumber,
              "password": authentication.password
            }));

    if (response.statusCode == 201) {
      return Authentication.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  // * Login
  Future<String> login(Authentication authentication) async {
    final http.Response response = await http.post(Uri.parse("$_baseUrl/login"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "auth-token": ""
        },
        body: jsonEncode({
          "email": authentication.email,
          "password": authentication.password
        }));

    if (response.statusCode == 200) {
      print("Auth-token");
      print(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('auth-token', response.body);
      print("Logged in from data provider");
      return response.body;
    } else if (response.statusCode == 400) {
      throw Exception(response.body);
    } else {
      throw Exception("Failed to login");
    }
  }

  Future<Authentication> update(Authentication authentication) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth-token');
    if (token == null) {
      throw Exception("Couldn't find token");
    }
    final response = await http.put(Uri.parse("$_baseUrl/updateAccount"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "auth-token": "$token",
        },
        body: jsonEncode({
          "name": authentication.name,
          "email": authentication.email,
          "phoneNumber": authentication.phoneNumber,
          "password": authentication.password
        }));

    if (response.statusCode == 200) {
      return Authentication.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update account");
    }
  }

  Future<void> delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth-token');
    if (token == null) {
      throw Exception("Couldn't find token");
    }
    final response = await http.delete(Uri.parse("$_baseUrl/delete"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "auth-token": "$token"
        });
    if (response.statusCode != 204) {
      throw Exception("Failed to delete account");
    }
  }
}