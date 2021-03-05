import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_1/labs/SecondLab/camera_screen.dart';

void main() => runApp(CameraApp());

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.purple[500]));
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple[500],
      ),
      debugShowCheckedModeBanner: false,
      home: CameraScreen(),
    );
  }
}
