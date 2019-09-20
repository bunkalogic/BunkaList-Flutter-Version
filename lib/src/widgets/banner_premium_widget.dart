import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class BannerPremiumWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: [
                Colors.purple[800],
                Colors.purple[700],
                Colors.purple[600],
                Colors.purple[500]
              ]
            ) 
          ),
          child: _buttomGoToPremium(),
      ),
    );
  }

  Widget _buttomGoToPremium() {
    return ListTile(
      title: _titleGoToPremium(),
      subtitle: subtitleGoToPremium(),
      leading: Icon(Icons.local_play, size: 40.0, color: Colors.orange[600],),
      onTap: () {},
    );
  }

  Widget _titleGoToPremium() {
    return Text(
      'Go to premium', 
    style: TextStyle(color: Colors.white, fontSize: 18.0 ),
    //textAlign: TextAlign.center,
    );
  }

  Widget subtitleGoToPremium() {
    return Text(
      'No ads other new features',
      style: TextStyle(color: Colors.white, fontSize: 14.0 ),
    );
  } 
  
}