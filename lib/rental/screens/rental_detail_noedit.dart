import 'package:homerent/rental/blocs/blocs.dart';
import 'package:homerent/rental/models/rental.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/chat/models/ChatModel.dart';
import 'package:homerent/chat/screens/chat_page.dart';
import 'package:homerent/chat/bloc/chat/chat_event.dart';
import 'package:homerent/chat/bloc/chat/chat_state.dart';
import 'package:homerent/chat/bloc/chat/chat_bloc.dart';
import 'package:homerent/rental/screens/HomeScreen.dart';

import 'rental_add_update.dart';
import '../../routes.dart';
import 'rental_list.dart';

class RentalDetailNoEdit extends StatelessWidget {
  static const routeName = 'rentalDetailNoedit';
  final Rental rental;

  bool loggedIn;

  RentalDetailNoEdit({required this.rental, this.loggedIn = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.rental.address}'),
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (ctx, state) {
          if (state is ChatCreated) {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          }
        },
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text('Title: ${this.rental.address}'),
                subtitle: Image.network(
                    "http://10.0.2.2:3000/${this.rental.rentalImage}"),
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
              Text(this.rental.date ?? ""),
              ElevatedButton(
                  onPressed: () {
                    if (loggedIn) {
                      BlocProvider.of<ChatBloc>(context).add(CreateChat(
                          chatModel: ChatModel(user2Id: this.rental.userId)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("You must login"),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  child: Text("Start chat"))
            ],
          ),
        ),
      ),
    );
  }
}
