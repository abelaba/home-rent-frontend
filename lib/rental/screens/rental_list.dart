import 'package:homerent/auth/screens/user_settings.dart';
import 'package:homerent/rental/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/rental/models/rental.dart';
import 'package:homerent/rental/screens/search.dart';
import 'package:homerent/settings/constants.dart';

import 'rental_add_update.dart';
import 'rental_detail.dart';
import '../../routes.dart';

class RentalList extends StatefulWidget {
  static const routeName = 'rentalList';

  @override
  _RentalListState createState() => _RentalListState();
}

class _RentalListState extends State<RentalList> {
  @override
  void initState() {
    BlocProvider.of<RentalBloc>(context).add(RentalLoadMyProperties());
    super.initState();
  }

  String? address;
  String? date;
  String? type;
  int? bedrooms;
  int? bathrooms;
  int? area;
  int? price;

  Widget _card({required Rental rental}){
    return GestureDetector(
      onTap: () {
          Navigator.of(context).pushNamed(RentalDetail.routeName,
                    arguments: rental);
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
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.green,
        title: Text('My Properties'),
      ),
      body: BlocBuilder<RentalBloc, RentalState>(
        builder: (_, state) {
          if (state is RentalOperationFailure) {
              return Center(child: Text("Loading error", style: TextStyle(fontSize: 20),));
            
          }

          if (state is RentalOperationSuccess) {
            final rentals = state.rentals;

            if (rentals.length == 0) {
              return Center(child: Text("You dont have any properties", style: TextStyle(fontSize: 20),));
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
                      itemCount: rentals.length,
                      itemBuilder: (_, idx) {
                        final rental = rentals.elementAt(idx);

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
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => Navigator.of(context).pushNamed(
          AddUpdateRental.routeName,
          arguments: RentalArguments(edit: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
