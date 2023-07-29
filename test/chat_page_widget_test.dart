import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homerent/auth/bloc/login/login_bloc.dart';
import 'package:homerent/auth/data-provider/auth-data-provider.dart';
import 'package:homerent/auth/repository/authRepository.dart';
import 'package:homerent/auth/screens/update_account.dart';
import 'package:homerent/chat/bloc/chat/chat_bloc.dart';
import 'package:homerent/chat/data_providers/chat-data-provider.dart';
import 'package:homerent/chat/repository/chat-repository.dart';
import 'package:homerent/chat/screens/chat_page.dart';

import 'package:homerent/rental/blocs/blocs.dart';
import 'package:homerent/rental/blocs/image/image_bloc.dart';
import 'package:homerent/rental/data_providers/rental-data-provider.dart';
import 'package:homerent/rental/repository/rental-repository.dart';
import 'package:homerent/rental/screens/rental_add_update.dart';
import 'package:homerent/routes.dart';

void main() {
  testWidgets('Chat page widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (context) => ChatBloc(
            chatRepository: ChatRepository(dataProvider: ChatDataProvider())),
        child: ChatPage(),
      ),
    ));

    var text = find.byType(Text);
    expect(text, findsWidgets);
  });
}
