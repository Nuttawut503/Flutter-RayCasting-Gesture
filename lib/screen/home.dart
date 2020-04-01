import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:LX_KMUTT/counter.dart';
import 'package:LX_KMUTT/components/home-interactive.dart';
import 'package:LX_KMUTT/components/home-sidebar.dart';

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
        ChangeNotifierProvider(create: (_) => RoomCounter())
      ],
      child: Consumer<RoomCounter>(
        builder: (context, counter, _) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  BackgroundDismissal(),
                  InteractiveScreen(),
                  LeftSideButtons(),
                  RightSideButtons(),
                  Positioned(
                    left: 5.0,
                    bottom: 5.0,
                    child: Text((counter.roomName!=null)?'${counter.roomName}':'', style: GoogleFonts.risque(fontSize: 32.0, color: Colors.white))
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
