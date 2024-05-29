import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:downloaderpro/splash_screen.dart'; // Import your SplashScreen
import 'package:downloaderpro/home.dart'; // Import the HomePageScreen
import 'package:downloaderpro/url_input_page.dart';
import 'package:downloaderpro/search.dart';
import 'package:downloaderpro/settings_page.dart'; // Import the SettingsPage

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
      home: SplashScreen(), // Display SplashScreen as the initial screen
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
    HomePageScreen(), // HomePageScreen
    URLInputPage(),
    Search(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: tabs[currentTabIndex],
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

          ],
        ),
      ),
    );
  }
}
