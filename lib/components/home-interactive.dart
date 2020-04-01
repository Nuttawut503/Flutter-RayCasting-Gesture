import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:LX_KMUTT/counter.dart';
import 'package:LX_KMUTT/xmap.dart';

class BackgroundDismissal extends StatelessWidget {
  BackgroundDismissal({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        Provider.of<RoomCounter>(context, listen: false).changeTo(null);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color.fromRGBO(29, 38, 113, 1.0), Color.fromRGBO(195, 55, 100, 1.0)],
            stops: [0.1, 0.4]
          )
        )
      )
    );
  }
}

class InteractiveScreen extends StatelessWidget {
  InteractiveScreen({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: InteractiveMap()
        )
      ]
    );
  }
}

class InteractiveMap extends StatelessWidget {
  InteractiveMap({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<RoomCounter>(context);
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final RenderBox box = context.findRenderObject();
        final Offset localOffset = box.globalToLocal(details.globalPosition);
        final Offset percentOffset = Offset(localOffset.dx / box.size.width * 100, localOffset.dy / box.size.height * 100);
        Provider.of<RoomCounter>(context, listen: false).changeTo(percentOffset);
      },
      child: Container(
        width: 250.0,
        height: 300.0,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.black,
          image: DecorationImage(image: AssetImage('assets/images/kmutt.jpg'), fit: BoxFit.cover, alignment: Alignment.center)
        ),
        child: CustomPaint(
          painter: HightlightPainter(roomName: counter.roomName),
          child: Container()
        )
      )
    );
  }
}

class HightlightPainter extends CustomPainter {
  HightlightPainter({this.roomName});
  
  final String roomName;

  @override
  void paint(Canvas canvas, Size size) {
    print(roomName);
    if (roomName == null) {
      return;
    }
    Paint paint = new Paint()
      ..color = Color.fromRGBO(197, 197, 0, 0.7)
      ..style = PaintingStyle.fill;
    Path path = new Path();
    path.moveTo(Building.rooms[roomName].last.dx / 100 * size.width, Building.rooms[roomName].last.dy / 100 * size.height);
    Building.rooms[roomName].forEach((Offset point) {
      path.lineTo(point.dx / 100 * size.width, point.dy / 100 * size.height);
    });
    canvas.drawPath(path, paint);
    paint
      ..color = Color.fromRGBO(197, 197, 197, 0.6)
      ..strokeWidth = 3.9
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HightlightPainter oldDelegate) {
    return (oldDelegate.roomName != roomName);
  }
}
