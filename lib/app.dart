import 'package:flutter/material.dart';
import 'package:pdt/home.dart';
import 'package:pdt/util/customTheme.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Welcome to PDT',
        theme: customThemeData(),
        home: Home(
          title: '主页',
        ));
  }
}
