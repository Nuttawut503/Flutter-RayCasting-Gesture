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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final RenderBox box = context.findRenderObject();
        final Offset localOffset = box.globalToLocal(details.globalPosition);
        Provider.of<OffsetCounter>(context, listen: false).changeTo(localOffset);
      },
      child: Container(
        width: 250.0,
        height: 250.0,
        decoration: BoxDecoration(color: Colors.black),
        child: Image.asset('assets/images/kmutt.jpg', fit: BoxFit.cover, alignment: Alignment.center)
      )
    );
  }
}

class SideButtons extends StatelessWidget {
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

// class _HomeScreen extends State<HomeScreen> {

//   Widget sideButtons() {
//     return Wrap(
//       direction: Axis.vertical,
//       children: <Widget>[
//         IconButton(
//           icon: Icon(Icons.help),
//           iconSize: 36.0,
//           onPressed: null
//         ),
//         IconButton(
//           icon: Icon(Icons.message),
//           iconSize: 36.0,
//           onPressed: null
//         ),
//         IconButton(
//           icon: Icon(Icons.calendar_view_day),
//           iconSize: 36.0,
//           onPressed: null
//         ),
//         IconButton(
//           icon: Icon(Icons.navigate_next),
//           iconSize: 36.0,
//           onPressed: null
//         )
//       ]
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(image: AssetImage('assets/images/bluegrid.jpg'), fit: BoxFit.cover)
//           ),
//           child: Stack(
//             children: <Widget>[
//               Center(
//                 child: BoxGesture() 
//               ),
//               Positioned(
//                 top: 20.0,
//                 right: 16.0,
//                 child: sideButtons()
//               )
//             ]
//           )
//         )
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () { Navigator.pushNamed(context, '/test1'); },
//         backgroundColor: Color.fromRGBO(255, 199, 44, 1.0),
//       )
//     );
//   }
// }

// class BoxGesture extends StatelessWidget {

//   void getPosition(BuildContext context, TapDownDetails details) {
//     final RenderBox box = context.findRenderObject();
//     final Offset localOffset = box.globalToLocal(details.globalPosition);
//     final double horizon = localOffset.dx / box.size.width * 100;
//     final double vertical = localOffset.dy / box.size.height * 100;
//     String position = 'You touched at the ';
//     if (vertical <= 33.33) {
//       position += (horizon <= 33.33)?'Top Left':((horizon > 66.66)?'Top Right':'Top');
//     } else if (vertical > 66.66) {
//       position += (horizon <= 33.33)?'Bottom Left':((horizon > 66.66)?'Bottom Right':'Bottom');
//     } else {
//       position += (horizon <= 33.33)?'Left':((horizon > 66.66)?'Right':'Center');
//     }
//     position += '\n(X:${horizon.toStringAsFixed(2)}%, Y:${vertical.toStringAsFixed(2)}%)';
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Yay!!'),
//         content: Text(position)
//       )
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (TapDownDetails details) => getPosition(context, details), 
//       child: Container(
//         width: 300.0,
//         height: 250.0,
//         decoration: BoxDecoration(
//           border: Border.all(width: 1.0),
//           color: Colors.white
//         ),
//         child: CustomPaint(
//           painter: MyPainter(),
//           child: Center(
//             child: Text(
//               'Touch me..',
//               style: GoogleFonts.openSans(fontSize: 30.0)
//             )
//           )
//         )
//       )
//     );
//   }
// }

// class MyPainter extends CustomPainter {
//   final Color myCustomColor;

//   MyPainter({this.myCustomColor = const Color.fromRGBO(200, 200, 0, 0.7)});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = new Paint()
//       ..color = myCustomColor
//       ..style = PaintingStyle.fill;
//     Path path = new Path()
//       ..moveTo(0, 0)
//       ..lineTo(size.width / 2, size.height / 1.5)
//       ..moveTo(0, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width / 2, size.height / 1.5);
//     canvas.drawPath(path, paint);
//   }
  
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
