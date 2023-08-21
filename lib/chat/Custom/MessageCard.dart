import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageCard extends StatefulWidget {
  const MessageCard(
      {Key? key,
      required this.message,
      required this.time,
      required this.senderName,
      required this.senderEmail})
      : super(key: key);
  final String message;
  final String time;
  final String senderName;
  final String senderEmail;

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {

  String? loggedInEmail;

  @override
  void initState() {
    super.initState();
    _loadLoggedInEmail();
  }

  

  Future<void> _loadLoggedInEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedInEmail = prefs.getString('email'); // Load the user's email
    });
    
  }


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.senderEmail == loggedInEmail
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: widget.senderEmail == loggedInEmail? Color(0xffdcf8c6): Colors.greenAccent,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(
                  widget.message,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      widget.time.substring(12, 16),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}