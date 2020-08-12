import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_downloader/dp.dart';
import 'package:instagram_downloader/alert.dart';

class Video extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  int _selectedText = 0;
  String url;
  String name;
  String progressString;
  String task = "Not Downloading";
  bool downloading = false;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  void download() async {
    FlutterInsta flutterInsta = FlutterInsta();
    var path1 = await getExternalStorageDirectory();
    Dio dio = Dio();
    try {
      var s = await flutterInsta.downloadReels(url);
      await dio.download(
        s,
        "${path1.path}/$name.mp4",
        onReceiveProgress: (count, total) => setState(() {
          downloading = true;
          progressString = ((count / total) * 100).toStringAsFixed(0) + "%";
        }),
      );
      print("Downloaded");
      await flutterInsta.getProfileData("shivani_narayanan");
      var image = await flutterInsta.imgurl;
      await dio.download(image.toString(), "${path1.path}/sample3.jpg");
      setState(() {
        downloading = false;
        progressString = "Completed";
        task = "Download Completed";
      });
    } catch (e) {
      task = "error";
      print(e);
    }
  }

  @override
  void dispose() {
    myController.dispose();
    myController2.dispose();
    super.dispose();
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
        actions: [
          FaIcon(
            FontAwesomeIcons.instagram,
            size: 45,
          )
        ],
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
                  maxLength: 39,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                  decoration: InputDecoration(
                    hintText: "Paste the URL here",
                  ),
                  onChanged: (value) {
                    setState(() {
                      url = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: myController2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter a name for the video",
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Center(
                    child: RaisedButton(
                  child: Text(
                    "Download Video",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    setState(() {
                      download();
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                )),
                SizedBox(height: 20),
                Center(
                    child: downloading
                        ? Container(
                            height: 120.0,
                            width: 200.0,
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "Downloading File: $progressString",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Text("$task",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.white))),
              ],
            ),
          )),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedText = value;
      if (_selectedText == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Dp()));
      } else if (_selectedText == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Alert()));
      }
    });
  }
}
