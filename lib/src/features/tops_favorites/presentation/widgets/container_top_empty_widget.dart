import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';


class ContainerTopEmptyWidget extends StatefulWidget {
  
  final String labelTitle;
  final String label;
  final Color dottedColor;
  final IconData  icon;
  final Function onTap;


  ContainerTopEmptyWidget({
    @required this.labelTitle,
    @required this.label,
    @required this.dottedColor,
    @required this.icon,
    @required this.onTap
  });

  @override
  _ContainerTopEmptyWidgetState createState() => _ContainerTopEmptyWidgetState();
}

class _ContainerTopEmptyWidgetState extends State<ContainerTopEmptyWidget> {
  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15
      ),
      child: DottedBorder(
        dashPattern: [8, 8],
        borderType: BorderType.RRect,
        radius: Radius.circular(8),
        padding: const EdgeInsets.all(4),
        color: widget.dottedColor,
        strokeCap: StrokeCap.round,
        strokeWidth: 2.5,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: Colors.amberAccent[400],
                    size: 60,
                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    widget.labelTitle,
                    textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                    shadows: [
                      Shadow(
                        color: Colors.greenAccent[400],
                        blurRadius: 1.0,
                        offset: Offset(0.1, 0.1),
                      ),
                      Shadow(
                        color: Colors.blueAccent[400],
                        blurRadius: 1.0,
                        offset: Offset(-0.1, 0.1),
                      ),
                      Shadow(
                        color: Colors.redAccent[400],
                        blurRadius: 1.0,
                        offset: Offset(0.1, -0.1),
                      ),
                    ]
                  ),
                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    widget.label,
                    textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}