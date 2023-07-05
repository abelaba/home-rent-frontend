import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoggedInState extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoggedOutState extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginFailureState extends LoginState {
  final Exception exception;

  LoginFailureState(this.exception);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateAccountSuccess extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateAccountFailure extends LoginState {
  final Exception exception;

  UpdateAccountFailure(this.exception);

  @override
  // TODO: implement props
  List<Object> get props => [exception];
}