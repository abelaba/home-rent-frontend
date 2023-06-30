import 'package:homerent/rental/models/rental.dart';
import 'package:flutter/material.dart';
import 'package:homerent/rental/screen/HomeScreen.dart';
import 'package:homerent/rental/screen/rental_detail_noedit.dart';

import 'rental_add_update.dart';
import 'rental_detail.dart';
import 'rental_list.dart';

class CourseAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => HomeScreen());
    }

    if (settings.name == AddUpdateRental.routeName) {
      RentalArguments args = settings.arguments as RentalArguments;
      return MaterialPageRoute(
        builder: (context) => AddUpdateRental(
          args: args,
        ),
      );
    }

    if (settings.name == RentalDetail.routeName) {
      Rental rental = settings.arguments as Rental;
      return MaterialPageRoute(
        builder: (context) => RentalDetail(
          rental: rental,
        ),
      );
    }
    if (settings.name == RentalDetailNoEdit.routeName) {
      Rental rental = settings.arguments as Rental;
      return MaterialPageRoute(
        builder: (context) => RentalDetailNoEdit(
          rental: rental,
        ),
      );
    }

    return MaterialPageRoute(builder: (context) => RentalList());
  }
}

class RentalArguments {
  final Rental? rental;
  final bool edit;
  final bool? myProperty;
  RentalArguments({this.rental, required this.edit, this.myProperty});
}