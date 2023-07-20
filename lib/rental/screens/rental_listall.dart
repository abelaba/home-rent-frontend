import 'package:homerent/rental/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/rental/screens/rental_detail_noedit.dart';

import 'rental_add_update.dart';
import 'rental_detail.dart';
import '../../routes.dart';

class RentalListAll extends StatefulWidget {
  static const routeName = 'rentalListAll';
  bool loggedIn;
  RentalListAll({this.loggedIn = true});

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
      appBar: AppBar(
        leading: widget.loggedIn
            ? Container()
            : IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
        title: Text('All properties'),
      ),
      body: BlocBuilder<RentalBloc, RentalState>(
        builder: (_, state) {
          if (state is RentalOperationSuccess) {
            final courses = state.rentals;

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (_, idx) => ListTile(
                  key: const ValueKey("singlerental"),
                  title: Text('${courses.elementAt(idx).address}'),
                  // subtitle: Text('${courses.elementAt(idx).rentalImage}'),
                  subtitle: Image.network(
                      "http://10.0.2.2:3000/${courses.elementAt(idx).rentalImage}"),
                  onTap: () {
                    print(courses.elementAt(idx));
                    print(widget.loggedIn);
                    if (widget.loggedIn) {
                      Navigator.of(context).pushNamed(
                          RentalDetailNoEdit.routeName,
                          arguments: courses.elementAt(idx));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RentalDetailNoEdit(
                                  rental: courses.elementAt(idx),
                                  loggedIn: false)));
                    }
                  }),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
