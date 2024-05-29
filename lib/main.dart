import 'package:flutter/material.dart';
import 'package:downloaderpro/home.dart';
import 'home.dart';  // Import the HomePageScreen
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:downloaderpro/url_input_page.dart';
import 'package:downloaderpro/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _themeData = ThemeData.dark();

  void toggleTheme() {
    setState(() {
      if (_themeData == ThemeData.dark()) {
        _themeData = ThemeData.light();
      } else {
        _themeData = ThemeData.dark();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mp3 Downloader',
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      home: MyAppStateful(),
    );
  }
}

class MyAppStateful extends StatefulWidget {
  @override
  _MyAppStatefulState createState() => _MyAppStatefulState();
}

class _MyAppStatefulState extends State<MyAppStateful> {
  int currentTabIndex = 0;

  final List<Widget> tabs = [
    HomePageScreen(),  // HomePageScreen
    URLInputPage(),
    Search(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_for_offline),
            label: 'Download',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note_rounded),
            label: 'Search Music',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple[700],
              ),
              child: Text(
                'FitPro Free',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                setState(() {
                  currentTabIndex = 0;
                });
                Navigator.pop(context); // close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.download),
              title: Text('Mp3 Downloader'),
              onTap: () {
                setState(() {
                  currentTabIndex = 1;
                });
                Navigator.pop(context); // close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Video Search'),
              onTap: () {
                setState(() {
                  currentTabIndex = 2;
                });
                Navigator.pop(context); // close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}
