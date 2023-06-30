import 'package:homerent/rental/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'rental_add_update.dart';
import 'rental_detail.dart';
import 'rental_route.dart';

class RentalList extends StatefulWidget {
  static const routeName = '/';

  @override
  _RentalListState createState() => _RentalListState();
}

class _RentalListState extends State<RentalList> {
  @override
  void initState() {
    BlocProvider.of<RentalBloc>(context).add(RentalLoadMyProperties());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My properties'),
      ),
      body: BlocBuilder<RentalBloc, RentalState>(
        builder: (_, state) {
          if (state is RentalOperationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Couldn't do rental operation"),
              duration: Duration(seconds: 2),
            ));
          }

          if (state is RentalOperationSuccess) {
            final rentals = state.rentals;

            if (rentals.length == 0) {
              return Center(child: Text("You dont have any properties"));
            }

            return ListView.builder(
              itemCount: rentals.length,
              itemBuilder: (_, idx) => ListTile(
                  title: Text('${rentals.elementAt(idx).address}'),
                  // subtitle: Text('${courses.elementAt(idx).rentalImage}'),
                  subtitle: Image.network(
                      "http://10.0.2.2:3000/${rentals.elementAt(idx).rentalImage}"),
                  onTap: () {
                    Navigator.of(context).pushNamed(RentalDetail.routeName,
                        arguments: rentals.elementAt(idx));
                  }),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AddUpdateRental.routeName,
          arguments: RentalArguments(edit: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}