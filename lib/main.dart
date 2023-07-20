import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/auth/bloc/login/login_bloc.dart';
import 'package:homerent/auth/bloc/signup/signup_bloc.dart';
import 'package:homerent/auth/data-provider/auth-data-provider.dart';
import 'package:homerent/auth/repository/authRepository.dart';
import 'package:homerent/chat/bloc/chat/chat_bloc.dart';
import 'package:homerent/chat/bloc/message/message_bloc.dart';
import 'package:homerent/chat/data_providers/chat-data-provider.dart';
import 'package:homerent/chat/repository/chat-repository.dart';
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
  final ChatRepository chatRepository =
      ChatRepository(dataProvider: ChatDataProvider());
  runApp(MyApp(
    authenticationRepository: authenticationRepository,
    rentalRepository: rentalRepository,
    chatRepository: chatRepository,
  ));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final RentalRepository rentalRepository;
  final ChatRepository chatRepository;

  const MyApp({
    Key? key,
    required this.authenticationRepository,
    required this.rentalRepository,
    required this.chatRepository,
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
              RentalBloc(rentalRepository: this.rentalRepository),
        ),
        BlocProvider(
          create: (context) => ChatBloc(chatRepository: chatRepository),
        ),
        BlocProvider(
          create: (context) => MessageBloc(chatRepository: chatRepository),
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
