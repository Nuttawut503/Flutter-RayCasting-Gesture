import 'package:flutter/material.dart';
import 'package:LX_KMUTT/arguments.dart';

class TestScreen2 extends StatefulWidget {
  @override
  _TestScreen2 createState() => _TestScreen2();
}

class _TestScreen2 extends State<TestScreen2> {

  List<Widget> buttons() {
    return <Widget>[
      RaisedButton(
        child: Text('Send "Yes" back'),
        onPressed: () {
          Navigator.pop(context, 'yessss');
        },
      ),
      SizedBox(width: 16.0),
      RaisedButton(
        child: Text('Send "No" back'),
        onPressed: () {
          Navigator.pop(context, 'nooooo');
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final TestArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                args.msg ?? 'No variable passed',
                style: opensansStyle(size: 24.0),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: buttons()
              )
            ]
          )
        )
      )
    );
  }
}
