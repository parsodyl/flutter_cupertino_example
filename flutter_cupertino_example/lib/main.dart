import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_example/pages/home_page.dart';

void main() => runApp(FCEApp());

class FCEApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'FCE App',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xff239867),
      ),
      home: HomePage(),
    );
  }
}
