import 'package:flutter/material.dart';
import 'package:pdt/util/fileUtil.dart';

class Home extends StatefulWidget {
  final String title;
  @override
  Home({Key? key, required this.title}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _getTest() async {
    var FileUtil = new OperateFile();
    Map json = {'id': 'id1', 'content': []};
    Map _result = await FileUtil.createDir('test1');
    print(_result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            this.widget.title,
          ),
        ),
        body: Center(
          child:
              IconButton(icon: Icon(Icons.add), onPressed: () => {_getTest()}),
        ));
  }
}
