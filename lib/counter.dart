import 'package:flutter/material.dart';
import 'package:LX_KMUTT/xmap.dart';

class RoomCounter with ChangeNotifier {
  String _room;
  String get roomName => _room;

  void changeTo(Offset newOffset) {
    _room = Building.getRoomName(newOffset);
    notifyListeners();
  }
}