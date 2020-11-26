import 'package:flutter/material.dart';

class BottomLoader extends StatefulWidget {
  
  @override
  _BottomLoaderState createState() => _BottomLoaderState();
}

class _BottomLoaderState extends State<BottomLoader> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<Color> _colorAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 5));
    _colorAnimation = _animationController.drive(
      ColorTween(
        begin: Colors.deepPurpleAccent[400],
        end: Colors.pinkAccent[400]
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
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: _colorAnimation,
          ),
        ),
      ),
    );
  }
}