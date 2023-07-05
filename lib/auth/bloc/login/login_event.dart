import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:homerent/auth/model/Auth.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginLoad extends LoginEvent {
  const LoginLoad();

  @override
  List<Object> get props => [];
}

class UserLogin extends LoginEvent {
  final Authentication authentication;

  const UserLogin({required this.authentication});

  @override
  List<Object> get props => [authentication];

  @override
  String toString() => 'User Loggedin {user: $authentication}';
}

class UserLogOut extends LoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'Logged Out';
}

class UserUpdated extends LoginEvent {
  final Authentication authentication;

  const UserUpdated({required this.authentication});

  @override
  List<Object> get props => [authentication];

  @override
  String toString() => 'Account updated';
}