import 'package:flutter/material.dart';
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
                  LeftSideButtons(),
                  RightSideButtons(),
                  Positioned(
                    left: 5.0,
                    bottom: 5.0,
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
