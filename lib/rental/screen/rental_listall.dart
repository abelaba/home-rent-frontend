import 'package:homerent/rental/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/rental/screen/rental_detail_noedit.dart';

import 'rental_add_update.dart';
import 'rental_detail.dart';
import 'rental_route.dart';

class RentalListAll extends StatefulWidget {
  static const routeName = '/';

  @override
  _RentalListAllState createState() => _RentalListAllState();
}

class _RentalListAllState extends State<RentalListAll> {
  @override
  void initState() {
    BlocProvider.of<RentalBloc>(context).add(RentalLoadAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(),
      ),
      appBar: AppBar(
        title: Text('All properties'),
      ),
      body: BlocBuilder<RentalBloc, RentalState>(
        builder: (_, state) {
          if (state is RentalOperationFailure) {
            return Center(child: Text('Could not do rental operation'));
          }

          if (state is RentalOperationSuccess) {
            final courses = state.rentals;

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (_, idx) => ListTile(
                  title: Text('${courses.elementAt(idx).address}'),
                  // subtitle: Text('${courses.elementAt(idx).rentalImage}'),
                  subtitle: Image.network(
                      "http://10.0.2.2:3000/${courses.elementAt(idx).rentalImage}"),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        RentalDetailNoEdit.routeName,
                        arguments: courses.elementAt(idx));
                  }),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}