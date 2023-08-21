import 'package:homerent/rental/blocs/blocs.dart';
import 'package:homerent/rental/models/rental.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/rental/screens/HomeScreen.dart';
import 'package:homerent/settings/constants.dart';

import 'rental_add_update.dart';
import '../../routes.dart';
import 'rental_list.dart';

class RentalDetail extends StatefulWidget {
  static const routeName = 'rentalDetail';
  final Rental rental;

  RentalDetail({required this.rental});

  @override
  _RentalDetailState createState() => _RentalDetailState();
}

class _RentalDetailState extends State<RentalDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Rental Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddUpdateRental.routeName,
                arguments: RentalArguments(rental: widget.rental, edit: true),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _showDeleteConfirmationDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "${Constants.baseURL}/${widget.rental.rentalImage}",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Price: ${widget.rental.price}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Address: ${widget.rental.address}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20.0),
            _detailRow(Icons.home, 'Type', widget.rental.type, Colors.blue),
            _detailRow(Icons.bed, 'Bedrooms', widget.rental.bedrooms.toString(), Colors.green),
            _detailRow(Icons.bathtub, 'Bathrooms', widget.rental.bathrooms.toString(), Colors.orange),
            _detailRow(Icons.aspect_ratio, 'Area', '${widget.rental.area} sq.m', Colors.purple),
          ],
        ),
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

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Property'),
          content: Text('Are you sure you want to delete this property?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                BlocProvider.of<RentalBloc>(context)
                    .add(RentalDelete(widget.rental.sId!));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.routeName, (route) => false);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
