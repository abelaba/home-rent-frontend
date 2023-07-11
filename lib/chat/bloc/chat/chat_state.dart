import 'package:equatable/equatable.dart';
import 'package:homerent/chat/models/ChatModel.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatsLoading extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatState {
  final Iterable<ChatModel> chats;

  ChatLoaded([this.chats = const []]);

  @override
  List<Object> get props => [chats];
}

class ChatLoadFailed extends ChatState {
  final Exception exception;

  ChatLoadFailed(this.exception);

  @override
  List<Object> get props => [];
}

class ChatCreated extends ChatState {}

class ChatCreateFailed extends ChatState {
  final Exception exception;

  ChatCreateFailed(this.exception);

  @override
  List<Object> get props => [];
}