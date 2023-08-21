import 'package:homerent/rental/blocs/blocs.dart';
import 'package:homerent/rental/models/rental.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/chat/models/ChatModel.dart';
import 'package:homerent/chat/screens/chat_page.dart';
import 'package:homerent/chat/bloc/chat/chat_event.dart';
import 'package:homerent/chat/bloc/chat/chat_state.dart';
import 'package:homerent/chat/bloc/chat/chat_bloc.dart';
import 'package:homerent/rental/screens/HomeScreen.dart';
import 'package:homerent/settings/constants.dart';

import 'rental_add_update.dart';
import '../../routes.dart';
import 'rental_list.dart';

class RentalDetailNoEdit extends StatelessWidget {
  static const routeName = 'rentalDetailNoedit';
  final Rental rental;

  bool loggedIn;

  RentalDetailNoEdit({required this.rental, this.loggedIn = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes the position of the shadow
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(
                    "${Constants.baseURL}/${rental.rentalImage}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Price: \$${rental.price}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Address: ${rental.address}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20.0),
            _detailRow(Icons.home, 'Type', rental.type, Colors.blue),
            _detailRow(Icons.bed, 'Bedrooms', rental.bedrooms.toString(), Colors.green),
            _detailRow(Icons.bathtub, 'Bathrooms', rental.bathrooms.toString(), Colors.orange),
            _detailRow(Icons.aspect_ratio, 'Area', '${rental.area} sq.m', Colors.purple),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          if (loggedIn) {
            BlocProvider.of<ChatBloc>(context).add(CreateChat(
                chatModel: ChatModel(user2Id: this.rental.userId)));
            Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("You must log in"),
              duration: Duration(seconds: 2),
            ));
          }
        },
        child: Icon(Icons.chat),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 8.0),
          Text(
            '$label: $value',
            style: TextStyle(fontSize: 18, color: color),
          ),
        ],
      ),
    );
  }
}
