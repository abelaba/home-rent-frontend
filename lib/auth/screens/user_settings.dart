import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/auth/bloc/login/login_bloc.dart';
import 'package:homerent/auth/bloc/login/login_event.dart';
import 'package:homerent/auth/bloc/login/login_state.dart';
import 'package:homerent/auth/screens/login_view.dart';
import 'package:homerent/auth/screens/update_account.dart';

class UserSettingsScreen extends StatefulWidget {
  static const routeName = "userSettings";

  UserSettingsScreen({Key? key}) : super(key: key);

  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Delete property.'),
                Text('Are you sure you want to delete your account?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(UserDeleted());
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("User Account"),
        centerTitle: true,
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (_, state) {
          if (state is LoggedOutState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/", (route) => false);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.supervised_user_circle,
                size: 200,
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(UpdateAccount.routeName);
                },
                child: Text("Update Account"),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  _showMyDialog();
                },
                child: Text("Delete Account"),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(UserLoggedOut());
                },
                child: Text("LogOut"),
              )
            ],
          ),
        ),
      ),
    );
  }
}