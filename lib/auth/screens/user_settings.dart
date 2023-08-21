import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/auth/bloc/login/login_bloc.dart';
import 'package:homerent/auth/bloc/login/login_event.dart';
import 'package:homerent/auth/bloc/login/login_state.dart';
import 'package:homerent/auth/screens/update_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsScreen extends StatefulWidget {
  static const routeName = "userSettings";

  UserSettingsScreen({Key? key}) : super(key: key);

  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  String? email;

  @override
  void initState() {
    super.initState();
    
  }

  Future<String?> _loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
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
        backgroundColor: Colors.green,
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
              FutureBuilder<String?>(
                future: _loadEmail(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading indicator while waiting for data
                  } else if (snapshot.hasError) {
                    return Text('Error loading data'); // Handle any errors
                  } else {
                    final email = snapshot.data ?? ''; // Get the email value or set a default value
                    return Column(
                      children: [
                        Text(email,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)
                        ), // Display the email value
                        // Other widgets can be added here
                      ],
                    );
                  }
                },
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
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () {
                  _showMyDialog();
                },
                child: Text("Delete Account"),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(UserLoggedOut());
                },
                child: Text("Log out"),
              )
            ],
          ),
        ),
      ),
    );
  }
}