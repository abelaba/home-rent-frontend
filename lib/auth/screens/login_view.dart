import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/auth/bloc/login/login_bloc.dart';
import 'package:homerent/auth/bloc/login/login_state.dart';
import 'package:homerent/auth/bloc/login/login_event.dart';
import 'package:homerent/auth/data-provider/auth-data-provider.dart';
import 'package:homerent/auth/model/Auth.dart';
import 'package:homerent/auth/repository/authRepository.dart';

import 'package:homerent/auth/screens/sign_up_view.dart';
// import 'package:email_validator/email_validator.dart';

class LoginView extends StatefulWidget {
  static const routeName = "/login";

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _user = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _loginForm(),
          _showSignUpButton(context),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoggedInState) {
                    return Text("Logged In");
                  } else if (state is LoginFailureState) {
                    return Text("${state.exception}");
                  }
                  return Text("Hello");
                },
                listener: (_, state) {
                  if (state is LoggedInState) {
                    // Navigator.of(context).pushNamed(SignUpView.routeName);
                  }
                },
              ),
              _emailField(),
              _passwordField(),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (_, state) {
                  if (state is LoginLoading) {
                    return CircularProgressIndicator();
                  }
                  return _loginButton();
                },
              ),
            ],
          ),
        ));
  }

  Widget _emailField() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Email',
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Please enter username';
        }
        if (value!.length < 6) {
          return 'Length too short';
        }
        // if (!EmailValidator.validate(value)) {
        //   return 'Please Enter valid email';
        // }
        return null;
      },
      onSaved: (value) {
        setState(() {
          this._user["email"] = value!;
        });
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.security),
        hintText: 'Password',
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Please enter password';
        }
        if (value!.length < 8) {
          return 'Please length too short';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          this._user["password"] = value!;
        });
      },
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () async {
        final form = _formKey.currentState;
        if (form != null && form.validate()) {
          form.save();

          BlocProvider.of<LoginBloc>(context).add(UserLogin(
              authentication: Authentication(
                  email: this._user["email"],
                  password: this._user["password"])));
          print("loggedin");
        }
      },
      child: Text('Login'),
    );
  }

  Widget _showSignUpButton(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: Text('Don\'t have an account? Sign up.'),
        onPressed: () {
          Navigator.of(context).popAndPushNamed(SignUpView.routeName);
        },
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}