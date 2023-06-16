import 'package:equatable/equatable.dart';
import 'package:homerent/auth/model/Auth.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class UserSignUp extends SignUpEvent {
  final Authentication authentication;

  const UserSignUp({required this.authentication});

  @override
  List<Object> get props => [authentication];

  @override
  String toString() => 'User SignedUp {user: $authentication}';
}