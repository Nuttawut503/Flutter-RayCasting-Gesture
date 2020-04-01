import 'package:flutter/material.dart';
import 'dart:math';

// credit -> https://www.geeksforgeeks.org/how-to-check-if-a-given-point-lies-inside-a-polygon/

class Building {
  static final Map<String, List<Offset>> rooms = {
    'Room A': [
      Offset(0, 0),
      Offset(50, 0),
      Offset(50, 50),
      Offset(0, 50),
    ],
    'Room B': [
      Offset(50, 0),
      Offset(100, 0),
      Offset(100, 50),
      Offset(50, 50),
    ],
    'Room C': [
      Offset(0, 50),
      Offset(50, 50),
      Offset(50, 100),
      Offset(0, 100),
    ],
    'Room D': [
      Offset(50, 50),
      Offset(100, 50),
      Offset(100, 100),
      Offset(50, 100),
    ]
  };

  static bool onSegment(Offset p, Offset q, Offset r) {
    if (q.dx <= max(p.dx, r.dx) && q.dx >= min(p.dx, r.dx) && q.dy <= max(p.dy, r.dy) && q.dy >= min(p.dy, r.dy)) {
      return true;
    }
    return false;
  }

  static int orientation(Offset p, Offset q, Offset r) {
    double val = (q.dy - p.dy) * (r.dx - q.dx) - (q.dx - p.dx) * (r.dy- q.dy);
    if (val == 0) return 0;
    return (val > 0)?1:2;
  }

  static bool doInsection(Offset p1, Offset q1, Offset p2, Offset q2) {
    int o1 = orientation(p1, q1, p2);
    int o2 = orientation(p1, q1, q2);
    int o3 = orientation(p2, q2, p1);
    int o4 = orientation(p2, q2, q1);

    if (o1!=o2 && o3!=o4) {
      return true;
    }

    if (o1 == 0 && onSegment(p1, p2, q1)) return true;
    if (o2 == 0 && onSegment(p1, q2, q1)) return true;
    if (o3 == 0 && onSegment(p2, p1, q2)) return true;
    if (o4 == 0 && onSegment(p2, q1, q2)) return true; 
  
    return false;
  }

  static String getRoomName(Offset location) {
    if (location == null) return null;
    String result;
    rooms.forEach((String key, List<Offset> value) {
      if (result == null) {
        Offset extreme = Offset(101, location.dy);
        int count = 0, i = 0;
        do {
          int next = (i+1) % value.length;
          if (doInsection(value[i], value[next], location, extreme)) {
            if (orientation(value[i], location, value[next]) == 0) {
              if (onSegment(value[i], location, value[next])) {
                result = key;
              }
              count = 0;
              break;
            }
            ++count;
          }
          i = next;
        } while (i != 0);
        if (count % 2 == 1) result = key;
      }
    });
    return result;
  }
}
