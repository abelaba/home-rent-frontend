import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homerent/chat/models/ChatModel.dart';
import 'package:homerent/chat/models/MessageModel.dart';
import 'package:homerent/chat/bloc/message/message_state.dart';
import 'package:homerent/chat/bloc/message/message_event.dart';
import 'package:homerent/chat/repository/chat-repository.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final ChatRepository chatRepository;
  MessageBloc({required this.chatRepository}) : super(MessageInitial());

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is SendMessage) {
      yield MessageLoading();
      try {
        ChatModel message =
            await chatRepository.sendMessage(event.messageModel);
        print("your message has been sent");
        yield MessageSent(message: message);
      } catch (e) {
        yield MessageNotSent();
      }
    }
    if (event is LoadMessages) {
      yield MessageLoading();
      try {
        var messages = await chatRepository.loadMessages(event.chatId);
        print(messages);
        yield MessageLoaded(messages);
      } catch (e) {
        yield MessageLoadFailed();
      }
    }
  }
}