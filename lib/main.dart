import 'package:flutter/material.dart';
import 'package:instagram_downloader/video.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Instagram Downloader",
      home: Video(),
      debugShowCheckedModeBanner: false,
    );
  }
}
