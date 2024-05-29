import 'package:flutter/material.dart';
import 'search_video.dart';
import 'yourlibrary.dart';
import 'url_input_page.dart';
import 'search.dart';
import 'main.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.cyanAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.cyanAccent,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.cyanAccent),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Settings Page',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.cyanAccent,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            NeonButton(
              text: 'Go to Search Video',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchVideo()),
                );
              },
            ),
            SizedBox(height: 10),
            NeonButton(
              text: 'Go to Your Library',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YourLibrary()),
                );
              },
            ),
            SizedBox(height: 10),
            NeonButton(
              text: 'Go to URL Input Page',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => URLInputPage()),
                );
              },
            ),
            SizedBox(height: 10),
            NeonButton(
              text: 'Go to Search Page',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Search()),
                );
              },
            ),
            SizedBox(height: 30),
            NeonButton(
              text: 'Toggle Theme',
              onPressed: () {
                MyApp.of(context)?.toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NeonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  NeonButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.6),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.cyanAccent,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
