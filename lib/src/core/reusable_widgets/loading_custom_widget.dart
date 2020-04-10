

import 'package:flutter/material.dart';

class LoadingCustomWidget extends StatefulWidget {

  @override
  _LoadingCustomWidgetState createState() => _LoadingCustomWidgetState();
}

class _LoadingCustomWidgetState extends State<LoadingCustomWidget> with SingleTickerProviderStateMixin {
  
  
  AnimationController _animationController;
  Animation<Color> _colorAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 5));
    _colorAnimation = _animationController.drive(
      ColorTween(
        begin: Colors.deepPurpleAccent[400],
        end: Colors.tealAccent[400]
      )
    );
    _animationController.repeat();
    super.initState();
  }


  @override
dispose() {
  _animationController.dispose(); // you need this
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor: _colorAnimation,
      ),
    );
  }
}