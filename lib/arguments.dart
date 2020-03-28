import 'package:flutter/material.dart';

class TestArguments {
  final String msg;

  TestArguments(this.msg);
}

TextStyle opensansStyle({double size = 16.0, Color colour = Colors.black}) => TextStyle(
  fontFamily: 'OpenSans',
  fontSize: size,
  color: colour
);
