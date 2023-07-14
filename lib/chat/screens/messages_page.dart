import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/chat//Custom/MessageCard.dart';
import 'package:homerent/chat/bloc/chat/chat_bloc.dart';
import 'package:homerent/chat/bloc/chat/chat_event.dart';
import 'package:homerent/chat/bloc/message/message_bloc.dart';
import 'package:homerent/chat/bloc/message/message_state.dart';
import 'package:homerent/chat/bloc/message/message_event.dart';
import 'package:homerent/chat/models/ChatModel.dart';
import 'package:homerent/chat/models/MessageModel.dart';
import 'package:homerent/rental/screen/HomeScreen.dart';
import 'package:homerent/routes.dart';

class IndividualPage extends StatefulWidget {
  static const routeName = 'individualPage';
  final ChatArguments chatArguments;
  IndividualPage({Key? key, required this.chatArguments}) : super(key: key);

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  // late IO.Socket socket;
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    BlocProvider.of<MessageBloc>(context)
        .add(LoadMessages(widget.chatArguments.chatId));

    // connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leadingWidth: 200,
        leading: InkWell(
          onTap: () {
            BlocProvider.of<ChatBloc>(context).add(LoadChats());
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              CircleAvatar(
                child: Icon(Icons.person),
                radius: 20,
              ),
              Text(widget.chatArguments.user1Name),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              // height: MediaQuery.of(context).size.height - 170,
              child: BlocBuilder<MessageBloc, MessageState>(
                builder: (ctx, state) {
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                  });
                  if (state is MessageLoaded) {
                    print(state.messages.length);
                    if (state.messages.length == 0) {
                      return Center(
                        child: Text("You dont have any messages"),
                      );
                    }
                    return ListView.builder(
                        controller: _scrollController,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          if (index == state.messages.length) {
                            return Container(
                              height: 20,
                            );
                          }

                          return MessageCard(
                            message: state.messages.elementAt(index).message!,
                            time: state.messages.elementAt(index).time!,
                            senderName:
                                state.messages.elementAt(index).senderName!,
                          );
                        });
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 55,
                      child: Card(
                        margin: EdgeInsets.only(left: 5, right: 2, bottom: 10),
                        child: TextFormField(
                          controller: _controller,
                          maxLines: 5,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message...",
                              contentPadding: EdgeInsets.all(10)),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 7),
                      child: InkWell(
                        onTap: () {
                          print(_controller.text);
                          print(widget.chatArguments.chatId);

                          BlocProvider.of<MessageBloc>(context).add(SendMessage(
                              MessageModel(
                                  chatId: widget.chatArguments.chatId,
                                  message: _controller.text)));
                          BlocProvider.of<MessageBloc>(context)
                              .add(LoadMessages(widget.chatArguments.chatId));

                          _controller.clear();
                          // print(widget.chatArguments.messages);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green[800],
                          radius: 25,
                          child: Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}