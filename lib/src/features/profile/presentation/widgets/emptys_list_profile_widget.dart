import 'package:flutter/material.dart';


class ListProfileEmptyIconWidget extends StatelessWidget {

  final String title;
  final IconData icon;
  final Color color;


  const ListProfileEmptyIconWidget({
    @required this.title,
    @required this.icon,
    @required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _iconListProfileEmpty(),
          _labelListProfileEmpty(context)
        ],
      ),
    );
  }

  Widget _iconListProfileEmpty() {
    return Icon(
      icon,
      color: color,
      size: 60.0,
    );
  }

  Widget _labelListProfileEmpty(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }
}

