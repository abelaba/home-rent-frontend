import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'package:homerent/rental/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RentalDataProvider {
  static final String _baseUrl = "http://10.0.2.2:3000/api/rental";
  // static final String _baseUrl = "http://127.0.0.1:3000/api/rental";

  // * Create rental property
  Future<int> create(Rental rental) async {
    File rentalImage = File(((rental.rentalImage) as XFile).path);
    String filename = rentalImage.path.split('/').last;
    print(rentalImage.path);
    print(filename);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    if (token == null) {
      throw Exception("No token found");
    } else {
      var request = http.MultipartRequest('POST', Uri.parse("$_baseUrl/add"));
      request.headers
          .addAll({"Content-Type": "multiport/form-data", "auth-token": token});
      request.fields["address"] = rental.address;
      var file = await MultipartFile.fromPath("rentalImage", rentalImage.path,
          filename: filename, contentType: new MediaType('image', 'jpeg'));
      request.files.add(file);
      print(file.filename);

      var response = await request.send();
      print(response.request);

      print(response.statusCode);
      if (response.statusCode == 201) {
        return response.statusCode;
      } else {
        print("Error");
        throw Exception("Failed to create property");
      }
    }

    // final http.Response response = await http.post(Uri.parse("$_baseUrl/add"),
    //     headers: <String, String>{
    //       "Content-Type": "application/json",
    //       "auth-token":
    //           "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTMyOWFmYjcyZTE4MDU0YTg1ZWU0MGIiLCJpYXQiOjE2MzA4MzM5NTN9.N2EOLLVn3sbn3T8Wr0K-O9RNWlIqKiEPfu0Vep1IBHk"
    //     },
    //     body: jsonEncode(
    //       {"address": rental.address},
    //     ));
    // print(response.body);
    // if (response.statusCode == 201) {
    //   print(response.body);
    //   return Rental.fromJson(jsonDecode(response.body));
    // } else {
    //   print("Error");
    //   throw Exception("Failed to create property");
    // }
  }

  // * View all properties
  Future<List<Rental>> viewAll() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/viewAll"));
      if (response.statusCode == 200) {
        final rentals = jsonDecode(response.body) as List;
        return rentals.map((c) => Rental.fromJson(c)).toList();
      } else {
        print("Could not view all");
        throw Exception("Could not fetch properties");
      }
    } on SocketException {
      throw Exception("Couldn't find connection");
    }
  }

  Future<List<Rental>> viewMyProperties() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    if (token == null) {
      throw Exception("No token found");
    } else {
      try {
        final response = await http.get(Uri.parse("$_baseUrl/viewMyProperties"),
            headers: <String, String>{"auth-token": token});
        if (response.statusCode == 200) {
          final rentals = jsonDecode(response.body) as List;
          return rentals.map((c) => Rental.fromJson(c)).toList();
        } else {
          print("Could not view my properties");
          throw Exception("Could not fetch properties");
        }
      } on SocketException {
        throw Exception("Couldnt find connection");
      }
    }
  }

  Future<int> update(String id, Rental rental) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    if (token == null) {
      throw Exception("No token found");
    } else {
      print("From data provider print $id");
      File rentalImage = File(((rental.rentalImage) as XFile).path);
      var request =
          http.MultipartRequest('PUT', Uri.parse("$_baseUrl/update/$id"));
      request.headers
          .addAll({"Content-Type": "multiport/form-data", "auth-token": token});
      request.fields["address"] = rental.address;
      // * FOR SENDING FILE
      if (rentalImage != null) {
        String filename = rentalImage.path.split('/').last;
        var file = await MultipartFile.fromPath("rentalImage", rentalImage.path,
            filename: filename, contentType: new MediaType('image', 'jpeg'));
        request.files.add(file);
      }

      var response = await request.send();
      print(response.request);

      print(response.statusCode);
      if (response.statusCode == 201) {
        return response.statusCode;
      } else {
        print("Error");
        throw Exception("Failed to create property");
      }
    }

    // final response = await http.put(Uri.parse("$_baseUrl/update/$id"),
    //     headers: <String, String>{
    //       "Content-Type": "application/json",
    //       "auth-token":
    //           "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTIyMDJhODVkYzQyOTMxOWM2MDZmNWEiLCJpYXQiOjE2Mjk2Mzc0NzZ9.wzSZOAp1WdEV7F0SRPe3a8o5T97QkOdy8L-cbNbFtsM"
    //     },
    //     body: jsonEncode(
    //         {"address": rental.address, "rentalImage": rental.rentalImage}));

    // if (response.statusCode == 200) {
    //   return Rental.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception("Could not update the property");
    // }
  }

  Future<void> delete(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    if (token == null) {
      throw Exception("No token found");
    } else {
      print(id);
      final response = await http.delete(Uri.parse("$_baseUrl/delete/$id"),
          headers: <String, String>{
            "Content-Type": "application/json",
            "auth-token": token
          });
      if (response.statusCode != 204) {
        throw Exception("Failed to delete the property");
      }
    }
  }
}