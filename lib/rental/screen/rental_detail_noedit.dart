import 'package:homerent/rental/blocs/blocs.dart';
import 'package:homerent/rental/models/rental.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'rental_add_update.dart';
import 'rental_route.dart';
import 'rental_list.dart';

class RentalDetailNoEdit extends StatelessWidget {
  static const routeName = 'rentalDetailNoedit';
  final Rental rental;

  RentalDetailNoEdit({required this.rental});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.rental.address}'),
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Title: ${this.rental.address}'),
              subtitle: Image.network(
                  "http://10.0.2.2:3000/${this.rental.rentalImage}"),
            ),
            Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(this.rental.date ?? ""),
          ],
        ),
      ),
    );
  }
}