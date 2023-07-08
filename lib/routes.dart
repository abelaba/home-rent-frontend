import 'package:homerent/auth/screens/login_view.dart';
import 'package:homerent/auth/screens/sign_up_view.dart';
import 'package:homerent/auth/screens/update_account.dart';
import 'package:homerent/rental/models/rental.dart';
import 'package:flutter/material.dart';
import 'package:homerent/rental/screen/HomeScreen.dart';
import 'package:homerent/rental/screen/rental_detail_noedit.dart';
import 'package:homerent/rental/screen/rental_listall.dart';

import 'package:homerent/auth/screens/user_settings.dart';

import 'rental/screen/rental_add_update.dart';
import 'rental/screen/rental_detail.dart';
import 'rental/screen/rental_list.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => LoginView());
    }

    if (settings.name == SignUpView.routeName) {
      return MaterialPageRoute(builder: (context) => SignUpView());
    }

    if (settings.name == HomeScreen.routeName) {
      return MaterialPageRoute(builder: (context) => HomeScreen());
    }

    if (settings.name == UpdateAccount.routeName) {
      return MaterialPageRoute(
        builder: (context) => UpdateAccount(),
      );
    }

    if (settings.name == UserSettingsScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => UserSettingsScreen(),
      );
    }

    if (settings.name == AddUpdateRental.routeName) {
      RentalArguments args = settings.arguments as RentalArguments;
      return MaterialPageRoute(
        builder: (context) => AddUpdateRental(
          args: args,
        ),
      );
    }

    if (settings.name == RentalList.routeName) {
      return MaterialPageRoute(
        builder: (context) => RentalList(),
      );
    }

    if (settings.name == RentalListAll.routeName) {
      return MaterialPageRoute(
        builder: (context) => RentalListAll(),
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

    return null;
  }
}

class RentalArguments {
  final Rental? rental;
  final bool edit;
  final bool? myProperty;
  RentalArguments({this.rental, required this.edit, this.myProperty});
}