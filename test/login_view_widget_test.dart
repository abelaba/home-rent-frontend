import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homerent/auth/bloc/login/login_bloc.dart';
import 'package:homerent/auth/data-provider/auth-data-provider.dart';
import 'package:homerent/auth/repository/authRepository.dart';
import 'package:homerent/auth/screens/login.dart';
import 'package:homerent/chat/data_providers/chat-data-provider.dart';
import 'package:homerent/chat/repository/chat-repository.dart';
import 'package:homerent/main.dart';
import 'package:homerent/rental/data_providers/rental-data-provider.dart';
import 'package:homerent/rental/repository/rental-repository.dart';

void main() {
  testWidgets('Login view widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (context) => LoginBloc(
            authenticationRepository: AuthenticationRepository(
                dataProvider: AuthenticationDataProvider())),
        child: Login(),
      ),
    ));

    var emailField = find.byIcon(Icons.person);
    expect(emailField, findsOneWidget);

    var passwordField = find.byIcon(Icons.security);

    expect(passwordField, findsOneWidget);

    var loginButton = find.text("Login");
    expect(loginButton, findsOneWidget);

    
  });
}
