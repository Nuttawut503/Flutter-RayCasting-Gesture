import 'package:flutter/material.dart';

class OffsetCounter with ChangeNotifier {
  Offset _offset;
  Offset get offset => _offset;

  void changeTo(Offset newOffset) {
    _offset = newOffset;
    notifyListeners();
  }
}