import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {}

class SignUpInitial extends SignUpState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpSuccessState extends SignUpState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SignUpFailureState extends SignUpState {
  final Exception exception;

  SignUpFailureState(this.exception);
  @override
  // TODO: implement props
  List<Object> get props => [];
}