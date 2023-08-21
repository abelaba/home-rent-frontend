import 'package:homerent/auth/screens/user_settings.dart';
import 'package:homerent/rental/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/rental/models/models.dart';
import 'package:homerent/rental/screens/rental_detail_noedit.dart';
import 'package:homerent/rental/screens/search.dart';
import 'package:homerent/settings/constants.dart';

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

  Iterable<Rental>? rentals;

  @override
  void initState() {
    BlocProvider.of<RentalBloc>(context).add(RentalLoadAll());
    super.initState();
  }

  String? address;
  String? date;
  String? type;
  int? bedrooms;
  int? bathrooms;
  int? area;
  int? price;

  Widget _card({required Rental rental}) {
  return GestureDetector(
    onTap: () {
      if (widget.loggedIn) {
        Navigator.of(context).pushNamed(
          RentalDetailNoEdit.routeName,
          arguments: rental,
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RentalDetailNoEdit(
              rental: rental,
              loggedIn: false,
            ),
          ),
        );
      }
    },
    child: Card(
      key: ValueKey("singlerental"),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150, // Fixed image height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(
                  "${Constants.baseURL}/${rental.rentalImage}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rental.address,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Price: \$${rental.price}", // Format price with a dollar sign
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      drawer: widget.loggedIn? Drawer(child: UserSettingsScreen()): null,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: widget.loggedIn
            ? null
            : IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
        title: Text('All Properties'),
      ),
      body: BlocBuilder<RentalBloc, RentalState>(
        builder: (_, state) {
          if (state is RentalOperationFailure) {
              return Center(child: Text("Loading error", style: TextStyle(fontSize: 20),));
          }
          if (state is RentalOperationSuccess) {
            rentals = state.rentals;
            if(rentals == null || rentals!.length == 0){
              return Center(child: Text("No properties available", style: TextStyle(fontSize: 20), ));
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CollapsibleSearchFilter(onFilterApplied: ({
                            String? address,
                            String? date,
                            String? type,
                            int? bedrooms,
                            int? bathrooms,
                            int? area,
                            int? price,
                          }) {
                              setState(() {
                                this.address = address;
                                this.date = date;
                                this.type = type;
                                this.bedrooms = bedrooms;
                                this.bathrooms = bathrooms;
                                this.area = area;
                                this.price = price;
                              });
                             
                             print(this.address);
                          },
                        ),
                    SizedBox(height: 20,),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: rentals!.length,
                      itemBuilder: (_, idx) {
                          final rental = rentals!.elementAt(idx);

                          // Apply filters here
                          if ((address == null || rental.address.toLowerCase().contains(address!.toLowerCase())) &&
                              (area == null || rental.area >= area!) &&
                              (bathrooms == null || rental.bathrooms >= bathrooms!) &&
                              (bedrooms == null || rental.bedrooms >= bedrooms!) &&
                              (date == null || rental.date == date) &&
                              (price == null || rental.price <= price!) &&
                              (type == null || rental.type.toLowerCase() == type!.toLowerCase())) {
                                
                            return _card(rental: rental);
                          } else {
                            return SizedBox.shrink(); // Don't show this rental
                          }
                        },
                    ),
                  ],
                ),
              ),
            );
          // } else if (state is RentalOperationFailure) {
          //   return Center(child: Text(state.message));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
