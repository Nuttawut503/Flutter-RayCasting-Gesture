import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 247, 187, 1.0),
      body: SafeArea(
        child: Center(
          child: BoxGesture()
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () { Navigator.pushNamed(context, '/test1'); },
        backgroundColor: Color.fromRGBO(255, 199, 44, 1.0),
      ),
    );
  }
}

class BoxGesture extends StatelessWidget {

  void getPosition(BuildContext context, TapDownDetails details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    final double horizon = localOffset.dx / box.size.width * 100;
    final double vertical = localOffset.dy / box.size.height * 100;
    String position = 'You touched at the ';
    if (vertical <= 33.33) {
      position += (horizon <= 33.33)?'Top Left':((horizon > 66.66)?'Top Right':'Top');
    } else if (vertical > 66.66) {
      position += (horizon <= 33.33)?'Bottom Left':((horizon > 66.66)?'Bottom Right':'Bottom');
    } else {
      position += (horizon <= 33.33)?'Left':((horizon > 66.66)?'Right':'Center');
    }
    position += '\n(X:${horizon.toStringAsFixed(2)}%, Y:${vertical.toStringAsFixed(2)}%)';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Yay!!'),
        content: Text(position)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) => getPosition(context, details), 
      child: Container(
        width: 300.0,
        height: 250.0,
        decoration: BoxDecoration(border: Border.all(width: 1.0)),
        child: Center(
          child: Text(
            'Touch me..',
            style: GoogleFonts.openSans(fontSize: 30.0)
          )
        )
      )
    );
  }
}
