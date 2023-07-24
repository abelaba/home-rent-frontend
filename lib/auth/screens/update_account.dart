import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/auth/bloc/login/login_bloc.dart';
import 'package:homerent/auth/bloc/login/login_event.dart';
import 'package:homerent/auth/bloc/login/login_state.dart';
import 'package:homerent/auth/model/Auth.dart';
import 'package:homerent/rental/screens/HomeScreen.dart';

class UpdateAccount extends StatefulWidget {
  UpdateAccount({Key? key}) : super(key: key);
  static const routeName = "updateAccount";

  @override
  _UpdateAccountState createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _user = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Account"),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _updateForm(),
        ],
      ),
    );
  }

  Widget _updateForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<LoginBloc, LoginState>(builder: (_, state) {
              if (state is UpdateAccountSuccess) {
                return Text("Updated");
              } else if (state is UpdateAccountFailure) {
                return Text("${state.exception}");
              }
              return Container();
            }, listener: (_, state) {
              if (state is UpdateAccountSuccess) {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Account updated"),
                  duration: Duration(seconds: 2),
                ));
              }
            }),
            _nameField(),
            SizedBox(height: 10,),
            _emailField(),
            SizedBox(height: 10,),
            _passwordField(),
            SizedBox(height: 10,),
            _phoneNumber(),
            SizedBox(height: 10,),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (_, state) {
                if (state is LoginLoading) {
                  return CircularProgressIndicator();
                }
                return _updateAccountButton();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameField() {
    return TextFormField(
      key: const ValueKey("namefield"),
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Name',
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Please enter name";
        } else if (value!.length < 6) {
          return "Name too short";
        }
      },
      onSaved: (value) {
        this._user["name"] = value!;
      },
    );
  }

  Widget _emailField() {
    return TextFormField(
      key: const ValueKey("emailfield"),
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        hintText: 'Email',
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Please enter email";
        }
      },
      onSaved: (value) {
        this._user["email"] = value!;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      key: const ValueKey("passwordfield"),
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.security),
        hintText: 'Password',
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Please enter password";
        } else if (value!.length < 8) {
          return "Password too short";
        }
      },
      onSaved: (value) {
        this._user["password"] = value!;
      },
    );
  }

  Widget _phoneNumber() {
    return TextFormField(
      key: const ValueKey("phonenumberfield"),
      decoration: InputDecoration(
        icon: Icon(Icons.phone),
        hintText: 'Phone Number',
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Please enter phone number";
        } else if (value!.length != 10) {
          return "Phone number length not correct";
        }
      },
      onSaved: (value) {
        this._user["phoneNumber"] = value!;
      },
    );
  }

  Widget _updateAccountButton() {
    return ElevatedButton(
      onPressed: () async {
        final form = _formKey.currentState;
        if (form != null && form.validate()) {
          form.save();
          BlocProvider.of<LoginBloc>(context).add(UserUpdated(
              authentication: Authentication(
                  name: this._user["name"],
                  password: this._user["password"],
                  phoneNumber: this._user["phoneNumber"],
                  email: this._user["email"])));
          print("Updated");
        }
      },
      child: Text('Update'),
    );
  }
}
