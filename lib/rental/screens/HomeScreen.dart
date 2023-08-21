import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:homerent/rental/screens/rental_list.dart';
import 'package:homerent/rental/screens/rental_listall.dart';
import 'package:homerent/chat/models/ChatModel.dart';
import 'package:homerent/chat/screens/chat_page.dart';

import 'package:homerent/auth/screens/user_settings.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "homescreen";
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            RentalListAll(),
            RentalList(),
            ChatPage()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.green[100],
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            activeColor: Colors.green,
            inactiveColor: Colors.black,
              title: Text(
                'Home',
              ),
              icon: Icon(
                Icons.other_houses,
                key: const ValueKey("Home"),
              )),
          BottomNavyBarItem(
            activeColor: Colors.green,
            inactiveColor: Colors.black,
              title: Text('My Prop'),
              icon: Icon(
                Icons.home,
                key: const ValueKey("Post"),
              )),
          BottomNavyBarItem(
            activeColor: Colors.green,
            inactiveColor: Colors.black,
              title: Text(
                'Chats',
              ),
              icon: Icon(
                Icons.chat,
                key: const ValueKey("Chats"),
              )),
        ],
      ),
    );
  }
}
