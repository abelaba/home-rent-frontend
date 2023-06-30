import 'package:homerent/rental/blocs/blocs.dart';
import 'package:homerent/rental/models/rental.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'rental_add_update.dart';
import 'rental_route.dart';
import 'rental_list.dart';

class RentalDetail extends StatefulWidget {
  static const routeName = 'rentalDetail';
  final Rental rental;

  RentalDetail({required this.rental});

  @override
  _RentalDetailState createState() => _RentalDetailState();
}

class _RentalDetailState extends State<RentalDetail> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Delete property.'),
                Text('Would you like to delete this property?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                BlocProvider.of<RentalBloc>(context)
                    .add(RentalDelete(this.widget.rental.sId!));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RentalList.routeName, (route) => false);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.widget.rental.address}'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateRental.routeName,
              arguments:
                  RentalArguments(rental: this.widget.rental, edit: true),
            ),
          ),
          SizedBox(
            width: 32,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _showMyDialog();
              }),
        ],
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Title: ${this.widget.rental.address}'),
              subtitle: Image.network(
                  "http://10.0.2.2:3000/${this.widget.rental.rentalImage}"),
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
            Text(this.widget.rental.date ?? ""),
          ],
        ),
      ),
    );
  }
}