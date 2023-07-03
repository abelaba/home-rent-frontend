import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/auth/bloc/login/login_bloc.dart';
import 'package:homerent/auth/bloc/signup/signup_bloc.dart';
import 'package:homerent/auth/data-provider/auth-data-provider.dart';
import 'package:homerent/auth/repository/authRepository.dart';
import 'package:homerent/rental/blocs/blocs.dart';
import 'package:homerent/rental/blocs/image/image_bloc.dart';
import 'package:homerent/rental/data_providers/rental-data-provider.dart';
import 'package:homerent/rental/repository/rental-repository.dart';
import 'package:homerent/routes.dart';

import 'package:homerent/bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final RentalRepository rentalRepository =
      RentalRepository(RentalDataProvider());
  final AuthenticationDataProvider authenticationDataProvider =
      AuthenticationDataProvider();
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(dataProvider: authenticationDataProvider);
  runApp(MyApp(
    authenticationRepository: authenticationRepository,
    rentalRepository: rentalRepository,
  ));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final RentalRepository rentalRepository;

  const MyApp({
    Key? key,
    required this.authenticationRepository,
    required this.rentalRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                LoginBloc(authenticationRepository: authenticationRepository)),
        BlocProvider(
            create: (context) =>
                SignUpBloc(authenticationRepository: authenticationRepository)),
        BlocProvider(
          create: (context) =>
              RentalBloc(rentalRepository: this.rentalRepository)
                ..add(RentalLoadAll()),
        ),
        BlocProvider(
          create: (context) => ImageBloc(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}