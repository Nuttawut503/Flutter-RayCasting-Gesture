import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:LX_KMUTT/counter.dart';

class BackgroundDismissal extends StatelessWidget {
  BackgroundDismissal({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        Provider.of<OffsetCounter>(context, listen: false).changeTo(null);
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
    final counter = Provider.of<OffsetCounter>(context);
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final RenderBox box = context.findRenderObject();
        final Offset localOffset = box.globalToLocal(details.globalPosition);
        final Offset percentOffset = Offset(localOffset.dx / box.size.width * 100, localOffset.dy / box.size.height * 100);
        Provider.of<OffsetCounter>(context, listen: false).changeTo(percentOffset);
      },
      child: Container(
        width: 250.0,
        height: 250.0,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(image: AssetImage('assets/images/kmutt.jpg'), fit: BoxFit.cover, alignment: Alignment.center)
        ),
        child: CustomPaint(
          painter: HightlightPainter(tapOffset: counter.offset, box: context.findRenderObject()),
          child: Container()
        )
      )
    );
  }
}

class HightlightPainter extends CustomPainter {
  HightlightPainter({this.tapOffset, this.box});
  
  final Offset tapOffset;
  final RenderBox box;

  @override
  void paint(Canvas canvas, Size size) {
    if (tapOffset == null) {
      return;
    }
    Paint paint = new Paint()
      ..color = Color.fromRGBO(197, 197, 0, 0.7)
      ..style = PaintingStyle.fill;
    Path path = new Path();
    double xp, yp;
    if (tapOffset.dx < 50.0) {
      if (tapOffset.dy < 50.0) {
        xp = 0;
        yp = 0;
      } else {
        xp = 0;
        yp = box.size.height / 2;
      }
    } else {
      if (tapOffset.dy < 50.0) {
        xp = box.size.width / 2;
        yp = 0;
      } else {
        xp = box.size.width / 2;
        yp = box.size.height / 2;
      }
    }
    path
      ..moveTo(xp, yp)
      ..lineTo(xp + box.size.width / 2, yp)
      ..lineTo(xp + box.size.width / 2, yp + box.size.height / 2)
      ..lineTo(xp, yp + box.size.height / 2)
      ..lineTo(xp, yp);
    canvas.drawPath(path, paint);
    paint
      ..color = Color.fromRGBO(197, 197, 197, 0.6)
      ..strokeWidth = 3.9
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HightlightPainter oldDelegate) {
    return (oldDelegate.tapOffset != tapOffset);
  }
}
