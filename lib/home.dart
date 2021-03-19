import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String title;
  @override
  Home({Key key, @required this.title}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            this.widget.title,
          ),
        ),
        body: Center(
            child: Column(
          children: [
            Text(
              'test',
              style: Theme.of(context).textTheme.headline1,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'hello',
                  style: Theme.of(context).textTheme.bodyText2,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'text1----->',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextSpan(text: 'text2---->'),
                  ]),
            ),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () => ({
                      print('------->'),
                      print(Theme.of(context).textTheme.bodyText1)
                    }))
          ],
        )));
  }
}
