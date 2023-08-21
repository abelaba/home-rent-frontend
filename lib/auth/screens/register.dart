import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/auth/bloc/signup/signup_bloc.dart';
import 'package:homerent/auth/bloc/signup/signup_event.dart';
import 'package:homerent/auth/bloc/signup/signup_state.dart';
import 'package:homerent/auth/model/Auth.dart';

class Register extends StatefulWidget {
  static const routeName = "/register";
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _user = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/new.jpg'), fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 130),
                child: BlocConsumer<SignUpBloc, SignUpState>(
                  builder: (_, state) {
                    return Text(
                      'Create\nAccount',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 33),
                    );
                  }, listener: (_, state) {
                    if (state is SignUpSuccessState) {
                      Navigator.of(context).popAndPushNamed('/');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Successfully signed up"),
                        duration: Duration(seconds: 2),
                      ));
                    }
                    else if (state is SignUpFailureState) {
                      Navigator.of(context).popAndPushNamed('/');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("${state.exception.toString().substring(
                            10,
                          )}"),
                        duration: Duration(seconds: 2),
                      ));
                    }
                }),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextFormField(
                                key: const ValueKey("signupnamefield"),
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
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Name",
                                    
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                key: const ValueKey("signupemailfield"),
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return "Please enter email";
                                  }
                                },
                                onSaved: (value) {
                                  this._user["email"] = value!;
                                },
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Email",
                                    
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                key: const ValueKey("phonenumberfield"),
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
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Phone number",
                                    
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                key: const ValueKey("signuppasswordfield"),
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
                                style: TextStyle(color: Colors.black),
                                obscureText: true,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Password",
                                    
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                        key: const ValueKey("signupbutton"),
                                        color: Colors.black,
                                        onPressed: _signUp,
                                        icon: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).popAndPushNamed('/');
                                    },
                                    child: Text(
                                      'Sign In',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blueGrey,
                                          fontSize: 18),
                                    ),
                                    style: ButtonStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp(){
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
  }
}