import 'package:flutter/material.dart';
import 'package:downloaderpro/search_video.dart';
import 'package:downloaderpro/yourlibrary.dart';
import 'url_input_page.dart'; // Import the InputUrlPage file
import 'search.dart';
import 'main.dart';  // Import the main.dart file to access MyApp

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.mail_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search by music',
              hintStyle: TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.search, color: Colors.white70),
              filled: true,
              fillColor: Colors.grey[850],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 16.0),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            children: [
              _buildGridItem('Videos', 'assets/images.png', Colors.orange, context, SearchVideo()),
              _buildGridItem('Songs ', 'assets/podcasts.png', Colors.redAccent, context, Search()),
              _buildGridItem('Url Downloader ', 'assets/friends.png', Colors.blueAccent, context, URLInputPage()),
              _buildGridItem('Searched History', 'assets/feed.png', Colors.deepPurpleAccent, context, YourLibrary()),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'Poked you',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 80.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 35.0,
                    backgroundImage: AssetImage('assets/avatar${index + 1}.jpg'),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10.0),
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
        ],
      ),
    );
  }

  Widget _buildGridItem(String label, String imagePath, Color color, BuildContext context, Widget destinationPage) {
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
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, height: 60, width: 60),
              SizedBox(height: 8.0),
              Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
