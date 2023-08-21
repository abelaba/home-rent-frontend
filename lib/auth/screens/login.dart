
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/auth/bloc/login/login_bloc.dart';
import 'package:homerent/auth/bloc/login/login_event.dart';
import 'package:homerent/auth/bloc/login/login_state.dart';
import 'package:homerent/auth/model/Auth.dart';
import 'package:homerent/auth/screens/register.dart';
import 'package:homerent/rental/screens/HomeScreen.dart';
import 'package:homerent/rental/screens/rental_listall.dart';

class Login extends StatefulWidget {
  static const routeName = "/login";
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _user = {};

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/new.jpg'), fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // Container(),
              Container(
                padding: EdgeInsets.only(left: 35, top: 130),
                child: BlocConsumer<LoginBloc, LoginState>(
                  builder: (context, state) {
                    
                    return Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text("Welcome\nback", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 33),),
                    );
                  },
                  listener: (_, state) {
                    if(state is LoginFailureState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${state.exception.toString().substring(
                            10,
                          )}"),
                      duration: Duration(seconds: 2),
                    ));
                    }
                    if (state is LoggedInState) {
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    }
                  },
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                key: const ValueKey("loginemailfield"),
                                style: TextStyle(color: Colors.black),
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
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                key: const ValueKey("loginpasswordfield"),
                                style: TextStyle(),
                                obscureText: true,
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (value!.length < 8) {
                                    return 'Length too short';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onSaved: (value) {
                                  setState(() {
                                    this._user["password"] = value!;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign in',
                                    style: TextStyle(
                                        fontSize: 27, fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                        key: const ValueKey("loginbutton"),
                                        color: Colors.white,
                                        onPressed: login,
                                        icon: Icon(
                                          Icons.arrow_forward,
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    key: const ValueKey("signup"),
                                    onPressed: () {
                                      Navigator.of(context).popAndPushNamed(Register.routeName);
                                    },
                                    child: Text(
                                      'Sign Up',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff4c505b),
                                          fontSize: 18),
                                    ),
                                    style: ButtonStyle(),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => RentalListAll(loggedIn: false)));
                                    },
                                    child: Text(
                                      'View',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff4c505b),
                                          fontSize: 18),
                                    ),
                                    style: ButtonStyle(),
                                  ),
                                  
                                ],
                              ),
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

  void login() {
    final form = _formKey.currentState;
    print(form);
        if (form != null && form.validate()) {
          form.save();

          BlocProvider.of<LoginBloc>(context).add(UserLogin(
              authentication: Authentication(
                  email: this._user["email"],
                  password: this._user["password"])));
        }
  }
}