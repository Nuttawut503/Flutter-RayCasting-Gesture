import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}):super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OffsetCounter())
      ],
      child: Consumer<OffsetCounter>(
        builder: (context, counter, _) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  BackgroundDismissal(),
                  InteractiveScreen(),
                  SideButtons(),
                  Positioned(
                    bottom: 0,
                    child: Text((counter.offset!=null)?'${counter.offset.dx.toStringAsFixed(2)} and ${counter.offset.dy.toStringAsFixed(2)}':''),
                  )
                ]
              )
            )
          );
        }
      )
    );
  }
}

class OffsetCounter with ChangeNotifier {
  Offset _offset;
  Offset get offset => _offset;

  void changeTo(Offset newOffset) {
    _offset = newOffset;
    notifyListeners();
  }
}

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
          image: DecorationImage(image: AssetImage('assets/images/bluegrid.jpg'), fit: BoxFit.cover)
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
        Text(
          'Touch somewhere in the box below',
          style: GoogleFonts.openSans(fontSize: 27.0)
        ),
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

class SideButtons extends StatelessWidget {
  SideButtons({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.0,
      right: 16.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.new_releases),
            iconSize: 36.0,
            onPressed: () { Navigator.pushNamed(context, '/test1'); }
          ),
          IconButton(
            icon: Icon(Icons.mail),
            iconSize: 36.0,
            color: Colors.greenAccent,
            onPressed: null
          )
        ]
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
      ..color = Color.fromRGBO(197, 197, 0, 0.5)
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
    path.moveTo(xp, yp);
    path.lineTo(xp + box.size.width / 2, yp);
    path.lineTo(xp + box.size.width / 2, yp + box.size.height / 2);
    path.lineTo(xp, yp + box.size.height / 2);
    path.lineTo(xp, yp);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HightlightPainter oldDelegate) {
    print(oldDelegate.tapOffset != tapOffset);
    return (oldDelegate.tapOffset != tapOffset);
  }
}
