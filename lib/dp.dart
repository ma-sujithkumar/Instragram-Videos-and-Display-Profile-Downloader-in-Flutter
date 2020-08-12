import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_downloader/alert.dart';
import 'package:instagram_downloader/video.dart';
import 'package:instagram_downloader/imagescreen.dart';

class Dp extends StatefulWidget {
  @override
  _DpState createState() => _DpState();
}

class _DpState extends State<Dp> {
  bool _loaded = true;
  int _selectedText = 1;
  String url;
  String name = "";
  String username = "";
  String followers1 = "";
  String following = "";
  String bio = "";
  String website = "";
  String finalname = '';
  final myController = TextEditingController();
  void _onItemTapped(int value) {
    setState(() {
      _selectedText = value;
      if (_selectedText == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Video()));
      } else if (_selectedText == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Alert()));
      }
    });
  }

  void fetchDetails() async {
    FlutterInsta insta = FlutterInsta();
    await insta.getProfileData(name);
    setState(() {
      finalname = name;
      url = insta.imgurl;
      followers1 = "Followers: " + insta.followers;
      following = "Following: " + insta.following;
      bio = "Bio: " + insta.bio;
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text(
            "Instagram Video/Dp Downloader",
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
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [Colors.red[400], Colors.amber[200]])),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: myController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter the user name (Don't use @)",
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(children: [
                    RaisedButton(
                      child: Text(
                        "Generate Profile",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        setState(() {
                          _loaded = false;
                          fetchDetails();
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    SizedBox(width: 5),
                    RaisedButton(
                      child: Text(
                        "View Dp",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ImageScreen(text1: url)));
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ]),
                  SizedBox(height: 20),
                  _loaded
                      ? SingleChildScrollView(
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(finalname,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      SizedBox(height: 10),
                                      Text(
                                        following,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        followers1,
                                        style: TextStyle(
                                            color: Colors.pink, fontSize: 16),
                                      ),
                                      SizedBox(height: 3),
                                      SelectableText(
                                        website,
                                        style: TextStyle(
                                            color: Colors.pink, fontSize: 16),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        bio,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      SizedBox(height: 3),
                                    ],
                                  ),
                                ),
                              )),
                        )
                      : CircularProgressIndicator(),
                ],
              ),
            )));
  }
}
