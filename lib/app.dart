import 'package:flutter/material.dart';
import 'dart:io';

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Welcome to PDT',
        home: Scaffold(
          appBar: AppBar(
            title: Text('title------'),
          ),
          body: Center(
            child: Text('Hello---->'),
          ),
        ));
  }
}
