import 'package:flutter/material.dart';


class SolidButtonWidget extends StatefulWidget {
  
  final double widthSize;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color buttonColor;
  
  final EdgeInsetsGeometry marginTitle;
  final TextStyle titleStyle;
  final String title;
  final Function onTap;
  
  SolidButtonWidget({
    @required this.widthSize,
    @required this.padding,
    @required this.margin,
    @required this.buttonColor,
    @required this.title,
    @required this.marginTitle,
    @required this.titleStyle,
    @required this.onTap
  });

  @override
  _SolidButtonWidgetState createState() => _SolidButtonWidgetState();
}

class _SolidButtonWidgetState extends State<SolidButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.widthSize,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: widget.margin,
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: widget.buttonColor,
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                blurRadius: 1.5,
                color: Colors.blueGrey[400].withOpacity(0.4),
                spreadRadius: 1.0,
                
              )
            ]
          ),
          child: Container(
              margin: widget.marginTitle,
              child: Text(
                widget.title,
                style: widget.titleStyle,
                textAlign: TextAlign.center,
              ),
            ),
        ),
      ),
    );
  }
}