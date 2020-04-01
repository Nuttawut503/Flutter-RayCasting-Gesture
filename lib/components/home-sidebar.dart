import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeftSideButtons extends StatelessWidget {
  LeftSideButtons({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25.0,
      left: 12.0,
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12.0,
        children: <Widget>[
          GestureDetector(
            onTap: () { print('info@lx'); },
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(250, 70, 22, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  child: Center(
                    child: Text('KM\nUTT', style: GoogleFonts.sarabun(fontSize: 11.0, fontWeight: FontWeight.w600))
                  )
                ),
                Text("Info@LX", style: GoogleFonts.openSans(fontSize: 13, fontWeight: FontWeight.w600, height: 1.5))
              ],
            )
          ),
          GestureDetector(
            onTap: () { print('google map'); },
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/googlemap.png'), fit: BoxFit.contain))
                ),
                Text("Google Map", style: GoogleFonts.openSans(fontSize: 13, fontWeight: FontWeight.w600, height: 1.5))
              ],
            )
          )
        ]
      )
    );
  }
}

class RightSideButtons extends StatelessWidget {
  RightSideButtons({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25.0,
      right: 12.0,
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12.0,
        children: <Widget>[
          GestureDetector(
            onTap: () { print('ann.'); },
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/megaphone.png'), fit: BoxFit.contain))
                ),
                Text("Ann.", style: GoogleFonts.openSans(fontSize: 13, fontWeight: FontWeight.w600, height: 1.5))
              ],
            )
          ),
          GestureDetector(
            onTap: () { print('events'); },
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  child: Center(
                    child: Text('${(new DateTime.now().day).toString().padLeft(2, "0")}', style: GoogleFonts.sarabun(fontSize: 16.0, fontWeight: FontWeight.w700))
                  )
                ),
                Text("Events", style: GoogleFonts.openSans(fontSize: 13, fontWeight: FontWeight.w600, height: 1.5))
              ],
            )
          ),
          GestureDetector(
            onTap: () { print('helps'); },
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/helper.png'), fit: BoxFit.contain))
                ),
                Text("Helps", style: GoogleFonts.openSans(fontSize: 13, fontWeight: FontWeight.w600, height: 1.5))
              ],
            )
          )
        ]
      )
    );
  }
}
