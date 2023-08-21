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
          BlocConsumer<LoginBloc, LoginState>(
            builder: (_, state) {
              if (state is UpdateAccountSuccess) {
                return Text(
                  "Updated",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else if (state is UpdateAccountFailure) {
                return Text(
                  "${state.exception}",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              return Container();
            },
            listener: (_, state) {
              if (state is UpdateAccountSuccess) {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Account updated"),
                  duration: Duration(seconds: 2),
                ));
              }
            },
          ),
          _nameField(),
          SizedBox(height: 10),
          _emailField(),
          SizedBox(height: 10),
          _passwordField(),
          SizedBox(height: 10),
          _phoneNumber(),
          SizedBox(height: 20),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (_, state) {
              if (state is LoginLoading) {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                );
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
      labelText: 'Name',
      prefixIcon: Icon(Icons.person),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter name";
      } else if (value.length < 6) {
        return "Name must be at least 6 characters";
      }
      return null;
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
      labelText: 'Email',
      prefixIcon: Icon(Icons.email),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter email";
      }
      return null;
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
      labelText: 'Password',
      prefixIcon: Icon(Icons.security),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter password";
      } else if (value.length < 8) {
        return "Password must be at least 8 characters";
      }
      return null;
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
      labelText: 'Phone Number',
      prefixIcon: Icon(Icons.phone), // Icon before the input field
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    keyboardType: TextInputType.phone,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter phone number";
      } else if (value.length != 10) {
        return "Phone number must be 10 digits";
      }
      return null;
    },
    onSaved: (value) {
      this._user["phoneNumber"] = value!;
    },
  );
}


  Widget _updateAccountButton() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: ElevatedButton(
      onPressed: () async {
        final form = _formKey.currentState;
        if (form != null && form.validate()) {
          form.save();
          BlocProvider.of<LoginBloc>(context).add(UserUpdated(
            authentication: Authentication(
              name: this._user["name"],
              password: this._user["password"],
              phoneNumber: this._user["phoneNumber"],
              email: this._user["email"],
            ),
          ));
          print("Updated");
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Button background color
        padding: EdgeInsets.symmetric(vertical: 16), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Button border radius
        ),
      ),
      child: Text(
        'Update',
        style: TextStyle(
          fontSize: 18, // Button text font size
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

}
