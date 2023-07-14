import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/chat/bloc/chat/chat_bloc.dart';
import 'package:homerent/chat/bloc/chat/chat_event.dart';
import 'package:homerent/chat/bloc/chat/chat_state.dart';
import 'package:homerent/chat/models/ChatModel.dart';
import 'package:homerent/chat/screens/messages_page.dart';

import '../../routes.dart';

class ChatPage extends StatefulWidget {
  static const routeName = "chatpage";
  ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ChatBloc>(context).add(LoadChats());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _customCard(ChatModel chatModel) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, IndividualPage.routeName,
            arguments: ChatArguments(
                chatId: chatModel.sId!,
                user1Id: chatModel.user1Id!,
                user2Id: chatModel.user2Id!,
                user1Name: chatModel.user1Name!,
                user2Name: chatModel.user2Name!,
                messages: chatModel.messages));
      },
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Icon(Icons.person),
          ),
          trailing: Text(chatModel.user1Name!),
          title: Text(chatModel.user2Name!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle: Row(
            children: [
              Icon(Icons.message_outlined),
              SizedBox(
                width: 5,
              ),
              Text(
                chatModel.messages!.length != 0
                    ? "${chatModel.messages![chatModel.messages!.length - 1]["message"]}"
                    : " ",
                style: TextStyle(fontSize: 13),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(LoadChats());
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("Chats"),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            if (state.chats.length == 0) {
              return Center(
                child: Text("You dont have any chats"),
              );
            }
            print(state.chats.elementAt(0).sId);

            return ListView.builder(
                itemCount: state.chats.length,
                itemBuilder: (_, idx) =>
                    _customCard(state.chats.elementAt(idx)));
          }
          if (state is ChatLoadFailed) {
            return Text("Chat load failed");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  }