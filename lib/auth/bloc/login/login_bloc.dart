import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homerent/auth/bloc/login/login_state.dart';
import 'package:homerent/auth/bloc/login/login_event.dart';
import 'package:homerent/auth/repository/authRepository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginBloc({
    required this.authenticationRepository,
  }) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is UserLogin) {
      yield LoginLoading();
      try {
        await authenticationRepository.login(event.authentication);
        print("Logged in");
        yield LoggedInState();
      } on Exception catch (e) {
        yield LoginFailureState(e);
      }
    }
    if (event is UserLogOut) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('auth-token');
        yield LoggedOutState();
      } catch (e) {
        yield LoginFailureState(Exception("LogOutfailed"));
      }
    }
  }
}