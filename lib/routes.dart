import 'package:homerent/auth/screens/login.dart';
import 'package:homerent/auth/screens/register.dart';
import 'package:homerent/auth/screens/update_account.dart';
import 'package:homerent/chat/screens/chat_page.dart';
import 'package:homerent/chat/screens/message_page.dart';
import 'package:homerent/rental/models/rental.dart';
import 'package:flutter/material.dart';
import 'package:homerent/rental/screens/HomeScreen.dart';
import 'package:homerent/rental/screens/rental_detail_noedit.dart';
import 'package:homerent/rental/screens/rental_listall.dart';

import 'package:homerent/auth/screens/user_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'rental/screens/rental_add_update.dart';
import 'rental/screens/rental_detail.dart';
import 'rental/screens/rental_list.dart';

class AppRouter {

  static Future<bool> checkAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('auth-token');
    return authToken != null && authToken.isNotEmpty;
  }

  static Route? generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return FutureBuilder<bool>(
          future: checkAuthToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: CircularProgressIndicator());
            } else if (snapshot.data == true) {
              return HomeScreen(); // Auth token exists, navigate to home
            } else {
              return Login(); // Auth token doesn't exist, navigate to login
            }
          },
        );
      });
    }

    if (settings.name == Register.routeName) {
      return MaterialPageRoute(builder: (context) => Register());
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

    if (settings.name == ChatPage.routeName) {
      return MaterialPageRoute(
        builder: (context) => ChatPage(),
      );
    }
    if (settings.name == IndividualPage.routeName) {
      ChatArguments args = settings.arguments as ChatArguments;
      return MaterialPageRoute(
        builder: (context) => IndividualPage(chatArguments: args),
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

class ChatArguments {
  final String chatId;
  final String user1Id;
  final String user2Id;
  final String user1Name;
  final String user2Name;
  List<dynamic>? messages;
  ChatArguments(
      {required this.chatId,
      required this.user1Id,
      required this.user2Id,
      required this.user1Name,
      required this.user2Name,
      this.messages});
}
