import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class TitleTopsWidget extends StatefulWidget {

  final String typeLabel;
  final String titleLabel;
  final Function onTap;


  TitleTopsWidget({
    @required this.titleLabel,
    @required this.typeLabel,
    @required this.onTap
  });

  @override
  _TitleTopsWidgetState createState() => _TitleTopsWidgetState();
}

class _TitleTopsWidgetState extends State<TitleTopsWidget> {
  
  final Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      title: Text(
        widget.titleLabel,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        widget.typeLabel,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, color: Colors.blueGrey),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
        size: 28,
      ),
    );
  }
}