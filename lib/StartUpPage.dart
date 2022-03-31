import 'package:flutter/material.dart';
import 'package:grocery_app/HomePage.dart';
import 'OrderHistoryPage.dart';
import 'profile.dart';
import 'package:grocery_app/settings/settings_page.dart';
import 'package:grocery_app/address/add_address_page.dart';

class StartUpPage extends StatefulWidget {
  // const StartUpPage({Key? key}) : super(key: key);

  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    ProfilePage(),
    TrackingPage(),
    AddAddressPage(),
    SettingsPage()
  ];

  int _selectedIndex = 0;

  static  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    TrackingPage(),
    AddAddressPage(),
    ProfilePage(),
    SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _children[_currentIndex],
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.orangeAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_outlined),
            label: 'Address',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
