import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homerent/auth/repository/authRepository.dart';
import 'package:meta/meta.dart';
import 'package:homerent/auth/bloc/signup/signup_state.dart';
import 'package:homerent/auth/bloc/signup/signup_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository authenticationRepository;
  SignUpBloc({required this.authenticationRepository}) : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is UserSignUp) {
      yield SignUpLoading();
      try {
        await authenticationRepository.register(event.authentication);
        yield SignUpSuccessState();
      } on Exception catch (e) {
        yield SignUpFailureState(e);
      }
    }
  }
}