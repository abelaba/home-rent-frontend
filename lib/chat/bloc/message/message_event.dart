import 'package:equatable/equatable.dart';
import 'package:homerent/chat/models/MessageModel.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends MessageEvent {
  final MessageModel messageModel;

  SendMessage(this.messageModel);
  @override
  List<Object> get props => [messageModel];
}

class LoadMessages extends MessageEvent {
  final String chatId;

  LoadMessages(this.chatId);
}