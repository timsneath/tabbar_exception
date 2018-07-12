import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
// import 'theme.dart';
// import 'register.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GabHub',
      // theme: defaultTargetPlatform == TargetPlatform.android ? tealTheme
      //     : iOSTheme,
      home: new BottomNavBar(),
    );
  }
}