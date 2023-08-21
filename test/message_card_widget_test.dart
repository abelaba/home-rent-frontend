import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homerent/auth/bloc/login/login_bloc.dart';
import 'package:homerent/auth/data-provider/auth-data-provider.dart';
import 'package:homerent/auth/repository/authRepository.dart';
import 'package:homerent/auth/screens/update_account.dart';
import 'package:homerent/chat/Custom/MessageCard.dart';
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
  testWidgets('Message card widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: Scaffold(
        body: Center(
          child: MessageCard(
              senderEmail: "aaa@gmail.com",
              message: "message",
              time: "timjkhkjhkhkjhkhkjkhke",
              senderName: "senderName"),
        ),
      )),
    );

    var text = find.byType(Text);
    expect(text, findsWidgets);
    var stack = find.byType(Stack);
    expect(stack, findsWidgets);
    var align = find.byType(Align);
    expect(align, findsOneWidget);
  });
}
