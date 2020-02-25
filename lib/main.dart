import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Clock()));

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Color createColour() {
    var hours = DateTime.now().hour*2;
    var mins = DateTime.now().minute*2;
    var secs = DateTime.now().second*2;
    var millisec = DateTime.now().millisecond*2;
    var microsec = DateTime.now().microsecond*2;
    
    var string = "2$secs$millisec";
    print(string);
    var colour = Color.fromRGBO(hours, mins, secs, 1);
    print(colour);
    return colour;
  }

  String createText() {
    return "#${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
  }

  Color col = Colors.blue;
  String text = "";

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (v) {
      setState(() {
        col = createColour();
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
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 50, color: Colors.white),
          ),
        )
      )
    );
  }
}
