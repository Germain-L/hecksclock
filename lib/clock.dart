import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

//since clock needs to change it is stateful
class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  bool trueColours = false;

  //this widget is used to change how the clock looks
  Widget settings() {
    String colourType = "True colours";
    String desc;
    trueColours == true ?
      {colourType = "True colours", desc = "Currently displaying actual hex colours given by time"}
        :
      {colourType = "Brighter colours", desc = "Currently doubling each hex value (hours, min, secs) given by time"};

    return Container(
      //keeps the colour of the clock changing
      color: col,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              highlightColor: Colors.white70,
              hoverColor: Colors.white12,
              color: Colors.transparent,

              //flips which colour pattern to use on press
              onPressed: () => trueColours = !trueColours,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(colourType, style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
            ),
            SizedBox(height: 10),
            Text(desc, style: TextStyle(fontSize: 25, color: Colors.white))
          ],
        )
      )
    );
  }

  Color createRealColour() {
    //gets current time and splits into hours, mins and secs
    DateTime now = DateTime.now();
    int hours = now.hour;
    int mins = now.minute;
    int secs = now.second;

    //converts time to RGBO colour, 1 being opacity
    Color colour = Color.fromRGBO(hours, mins, secs, 1);
    return colour;
  }

  Color createFunColour() {
    // gets current time and splits into hours, mins and secs
    DateTime now = DateTime.now();
    int hours = now.hour*2;
    int mins = now.minute*2;
    int secs = now.second*2;

    // converts time to RGBO colour, 1 being opacity
    Color colour = Color.fromRGBO(hours, mins, secs, 1);
    return colour;
  }

  String createText() {
    //create the text to display
    DateTime now = DateTime.now();
    int h = now.hour;
    int m = now.minute;
    int s = now.second;

    String hours = h.toString();
    String minutes = m.toString();
    String seconds = s.toString();

    if (hours.length == 1) hours = "0"+hours;
    if (minutes.length == 1) minutes = "0"+minutes;
    if (seconds.length == 1) seconds = "0"+seconds;
    return "#$hours $minutes $seconds";
  }

  void animateOpacity() {
    //display settings or not
    setState(() {
      opacity == 0 ? opacity = 1 : opacity = 0;
    });
  }

  Color col = Colors.white;
  String text = "";
  double opacity;

  @override
  void initState() {
    super.initState();
    opacity = 0;

    // update clock every seconds
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
                //displayed if opacity is 1
                opacity: opacity,
              )
            ),

            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                width: MediaQuery.of(context).size.width*0.8,
                child: AutoSizeText("reproduction of jacopocolo.com/hexclock/", style: TextStyle(color: Colors.white38, fontSize: 18),)
              ),
            ),
            
            Positioned(
              right: 10,
              bottom: 10,
              child: IconButton(
                icon: Icon(Icons.settings, color: Colors.white54,),
                onPressed: () => animateOpacity()
              ),
            ),
          ],
        )
      )
    );
  }
}
