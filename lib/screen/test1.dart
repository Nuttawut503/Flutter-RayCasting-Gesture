import 'package:flutter/material.dart';
import 'package:LX_KMUTT/arguments.dart';

class TestScreen1 extends StatefulWidget {
  @override
  _TestScreen1 createState() => _TestScreen1();
}

class _TestScreen1 extends State<TestScreen1> {
  String textDisplay = 'Hello World';

  void deliveryTest() async {
    final result = await Navigator.pushNamed(
      context,
      '/test2',
      arguments: TestArguments('This msg was sent from Test1!!')
    );
    if (result != null) {
      setState(() {
        textDisplay = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 300.0,
                height: 200.0,
                child: Image.asset('assets/images/kmutt.jpg'),
              ),
              Text(
                '$textDisplay',
                style: opensansStyle(size: 27.0),
              ),
              RaisedButton(
                child: Text('Click Here to test'),
                onPressed: () {
                  deliveryTest();
                },
              )
            ]
          ),
        )
      )
    );
  }
}
