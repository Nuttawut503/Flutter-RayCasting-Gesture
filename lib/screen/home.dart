import 'package:flutter/material.dart';
import 'package:LX_KMUTT/arguments.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String textDisplay = 'Hello World';

  void deliveryTest() async {
    final result = await Navigator.pushNamed(
      context,
      '/debug',
      arguments: TestArguments('This msg was sent from Home!!')  
    );
    setState(() {
      textDisplay = result;
    });
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
