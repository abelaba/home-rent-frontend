import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/auth/bloc/signup/signup_bloc.dart';
import 'package:homerent/auth/data-provider/auth-data-provider.dart';
import 'package:homerent/auth/model/Auth.dart';
import 'package:homerent/auth/repository/authRepository.dart';
import 'package:homerent/auth/bloc/signup/signup_event.dart';
import 'package:homerent/auth/bloc/signup/signup_state.dart';
import 'package:homerent/auth/screens/login_view.dart';

class SignUpView extends StatefulWidget {
  static const routeName = "/signup";

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _user = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _signUpForm(),
          _showLoginButton(context),
        ],
      ),
    );
  }

  Widget _signUpForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<SignUpBloc, SignUpState>(builder: (_, state) {
              if (state is SignUpSuccessState) {
                return Text("SignedUp");
              } else if (state is SignUpFailureState) {
                return Text("${state.exception.toString().substring(
                      10,
                    )}");
              }
              return Text("Hello");
            }, listener: (_, state) {
              if (state is SignUpSuccessState) {
                Navigator.of(context).popAndPushNamed('/');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Successfully signed up"),
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
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (_, state) {
                if (state is SignUpLoading) {
                  return CircularProgressIndicator();
                }
                return _signUpButton();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameField() {
    return TextFormField(
      key: const ValueKey("signupnamefield"),
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
      key: const ValueKey("signupemailfield"),
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
      key: const ValueKey("signuppasswordfield"),
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

  Widget _signUpButton() {
    return ElevatedButton(
      key: const ValueKey("signupbutton"),
      onPressed: () async {
        final form = _formKey.currentState;
        if (form != null && form.validate()) {
          form.save();
          BlocProvider.of<SignUpBloc>(context).add(UserSignUp(
              authentication: Authentication(
                  name: this._user["name"],
                  password: this._user["password"],
                  phoneNumber: this._user["phoneNumber"],
                  email: this._user["email"])));
          print("Signed Up");
        }
      },
      child: Text('Sign Up'),
    );
  }

  Widget _showLoginButton(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: Text('Already have an account? Sign in.'),
        onPressed: () {
          Navigator.of(context).popAndPushNamed('/');
        },
      ),
    );
  }
}
