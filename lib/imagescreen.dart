import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_downloader/dp.dart';
import 'dart:math';

import 'package:random_string/random_string.dart';

class ImageScreen extends StatefulWidget {
  final String text1;
  ImageScreen({Key key, @required this.text1}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Dio dio = Dio();
  void download() async {
    String name = randomAlpha(5);
    var path1 = await getExternalStorageDirectory();
    await dio.download(widget.text1, "${path1.path}/$name.jpg");
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success!"),
            content: Text("Image has been Downloaded Successfully!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "Display Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [FaIcon(FontAwesomeIcons.instagram, size: 45)],
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
          child: Image.network(widget.text1),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.file_download),
          onPressed: () {
            setState(() {
              download();
            });
          }),
    );
  }
}
