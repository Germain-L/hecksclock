import 'dart:async';

import 'package:flutter/material.dart';
class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  bool trueColours = false;
  Widget settings() {
    String colourType = "True colours";
    String desc;
    trueColours == true ?
      {colourType = "True colours", desc = "Currently displaying actual hex colours given by time"}
        :
      {colourType = "Brighter colours", desc = "Currently doubling each hex value (hours, min, secs) given by time"};

    return Container(
      color: col,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: () => trueColours = !trueColours,
              child: Text(colourType, style: TextStyle(color: Colors.white, fontSize: 30),),
            ),
            SizedBox(height: 10),
            Text(desc, style: TextStyle(fontSize: 25, color: Colors.white))
          ],
        )
      )
    );
  }

  Color createRealColour() {
    int hours = DateTime.now().hour;
    int mins = DateTime.now().minute;
    int secs = DateTime.now().second;
    var colour = Color.fromRGBO(hours, mins, secs, 1);
    return colour;
  }

  Color createFunColour() {
    int hours = DateTime.now().hour*2;
    int mins = DateTime.now().minute*2;
    int secs = DateTime.now().second*2;
    var colour = Color.fromRGBO(hours, mins, secs, 1);
    return colour;
  }

  String createText() {
    return "#${DateTime.now().hour} ${DateTime.now().minute} ${DateTime.now().second}";
  }

  void animateOpacity() {
    print("changing opacity");
    setState(() {
      opacity == 0 ? opacity = 1 : opacity = 0;
    });
  }

  Color col = Colors.blue;
  String text = "";
  double opacity;

  @override
  void initState() {
    super.initState();
    opacity = 0;
    Timer.periodic(Duration(seconds: 1), (v) {
      setState(() {
        trueColours == true ? col = createRealColour() : col = createFunColour();
        text = createText();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedContainer(
        color: col,
        duration: Duration(milliseconds: 1000),
        child: Stack(
          children: <Widget>[

            Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
            ),

            Center(
              child: Opacity(
                child: settings(),
                opacity: opacity,
              )
            ),
            
            Positioned(
              right: 10,
              bottom: 10,
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => animateOpacity()
              ),
            ),
          ],
        )
      )
    );
  }
}