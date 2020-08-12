import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_downloader/dp.dart';
import 'package:instagram_downloader/video.dart';

class Alert extends StatefulWidget {
  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  int _selectedText = 2;
  void _onItemTapped(int value) {
    setState(() {
      _selectedText = value;
      if (_selectedText == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Dp()));
      } else if (_selectedText == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Video()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "Info",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [FaIcon(FontAwesomeIcons.instagram, size: 45)],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.video),
            title: Text("Video"),
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.image), title: Text("Dp")),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.info), title: Text("Info"))
        ],
        currentIndex: _selectedText,
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3, 1],
                colors: [Colors.red[400], Colors.amber[200]])),
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "1.To view the downloaded files, Go to File Manager -> Android -> data -> com.example.instagram_downloader -> files",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "2. To download Dp, Generate the Profile first",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
              ],
            )),
      ),
    );
  }
}
