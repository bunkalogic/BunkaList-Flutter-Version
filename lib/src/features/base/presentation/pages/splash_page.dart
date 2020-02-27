import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.purple[700],
            Colors.purple[900],  
            Colors.deepOrangeAccent[400],
          ], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: Center(
            child: Image(
              image: AssetImage('assets/bunkalist-banner.png'),
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
      ),
    );
  }
}