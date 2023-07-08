import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:homerent/rental/screen/rental_list.dart';
import 'package:homerent/rental/screen/rental_listall.dart';

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
            RentalList(),
            RentalListAll(),
            UserSettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Post'), icon: Icon(Icons.home)),
          BottomNavyBarItem(title: Text('Home'), icon: Icon(Icons.post_add)),
          BottomNavyBarItem(title: Text('Account'), icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}