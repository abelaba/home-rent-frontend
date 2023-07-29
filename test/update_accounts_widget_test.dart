import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homerent/auth/bloc/login/login_bloc.dart';
import 'package:homerent/auth/data-provider/auth-data-provider.dart';
import 'package:homerent/auth/repository/authRepository.dart';
import 'package:homerent/auth/screens/update_account.dart';

import 'package:homerent/rental/blocs/blocs.dart';
import 'package:homerent/rental/blocs/image/image_bloc.dart';
import 'package:homerent/rental/data_providers/rental-data-provider.dart';
import 'package:homerent/rental/repository/rental-repository.dart';
import 'package:homerent/rental/screens/rental_add_update.dart';
import 'package:homerent/routes.dart';

void main() {
  testWidgets('update account widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (context) => LoginBloc(
            authenticationRepository: AuthenticationRepository(
                dataProvider: AuthenticationDataProvider())),
        child: UpdateAccount(),
      ),
    ));

    var nameField = find.byIcon(Icons.person);
    expect(nameField, findsOneWidget);
    print(nameField);

    var emailField = find.byIcon(Icons.email);
    expect(emailField, findsOneWidget);

    var passwordField = find.byIcon(Icons.security);
    expect(passwordField, findsOneWidget);

    var phoneNumberField = find.byIcon(Icons.phone);

    expect(phoneNumberField, findsOneWidget);

    var updateButton = find.text("Update");
    expect(updateButton, findsOneWidget);
  });
}
