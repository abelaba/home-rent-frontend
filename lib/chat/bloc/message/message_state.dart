import 'package:equatable/equatable.dart';
import 'package:homerent/chat/models/ChatModel.dart';
import 'package:homerent/chat/models/MessageModel.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageLoading extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageLoaded extends MessageState {
  final Iterable<MessageModel> messages;

  MessageLoaded([this.messages = const []]);

  @override
  List<Object> get props => [messages];
}

class MessageLoadFailed extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageSent extends MessageState {
  final ChatModel message;
  MessageSent({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class MessageNotSent extends MessageState {
  @override
  List<Object> get props => [];
}