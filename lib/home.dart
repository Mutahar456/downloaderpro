import 'package:flutter/material.dart';
import 'package:downloaderpro/search_video.dart';
import 'package:downloaderpro/yourlibrary.dart';
import 'url_input_page.dart'; // Import the InputUrlPage file
import 'search.dart';
import 'settings_page.dart'; // Import the SettingsPage
import 'main.dart'; // Import the main.dart file to access MyApp

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color accentColor = isDarkTheme ? Colors.cyanAccent : Colors.blueAccent;
    Color textColor = isDarkTheme ? Colors.white : Colors.black;

    String greetingMessage = _getGreetingMessage();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.settings, color: accentColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
        actions: [
          Row(
            children: [
              Text('Dark Mode', style: TextStyle(color: accentColor)),
              Switch(
                value: isDarkTheme,
                onChanged: (value) {
                  MyApp.of(context)?.toggleTheme();
                },
                activeColor: accentColor,
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            greetingMessage,
            style: TextStyle(
              color: accentColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            children: [
              _buildGridItem('Videos', 'assets/images.jpg', Colors.orange, context, SearchVideo(), textColor),
              _buildGridItem('Songs', 'assets/podcasts.jpg', Colors.redAccent, context, Search(), textColor),
              _buildGridItem('Url Downloader', 'assets/url.jpg', Colors.blueAccent, context, URLInputPage(), textColor),
              _buildGridItem('Searched History', 'assets/searchhistory.jpg', Colors.deepPurpleAccent, context, YourLibrary(), textColor),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.6),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.music_note, color: Colors.white),
                SizedBox(width: 8.0),
                Text(
                  'Apricots - Bicep',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                Icon(Icons.favorite_border, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          MusicPlayerWidget(), // Add the music player interface below the text
        ],
      ),
    );
  }

  Widget _buildGridItem(String label, String imagePath, Color color, BuildContext context, Widget destinationPage, Color textColor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.6),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, height: 60, width: 60),
              SizedBox(height: 8.0),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.white,
                      offset: Offset(0, 0),
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


  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning Saleha';
    } else if (hour < 17) {
      return 'Good Afternoon Saleha';
    } else if (hour < 20) {
      return 'Good Evening Saleha';
    } else {
      return 'Good Night Saleha';
    }
  }
}

class MusicPlayerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determine if the current theme is dark
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    // Define colors based on the theme
    Color backgroundColor = isDarkTheme ? Colors.grey[800]! : Colors.grey[300]!;
    Color textColor = isDarkTheme ? Colors.white : Colors.black;

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.skip_previous, color: textColor),
              Expanded(
                child: Slider(
                  value: 0.5,
                  onChanged: (newValue) {},
                ),
              ),
              Icon(Icons.skip_next, color: textColor),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Song Title', style: TextStyle(color: textColor)),
              Text('2:45 / 4:30', style: TextStyle(color: textColor)),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow, color: textColor),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.pause, color: textColor),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
