import 'package:flutter/material.dart';

class ColumnBlockPremiumFeature extends StatefulWidget {
  ColumnBlockPremiumFeature({Key key}) : super(key: key);

  @override
  _ColumnBlockPremiumFeatureState createState() => _ColumnBlockPremiumFeatureState();
}

class _ColumnBlockPremiumFeatureState extends State<ColumnBlockPremiumFeature> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Funcion exclusiva de la version Premium',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, 
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
            shadows:  [
              Shadow(
                color: Colors.greenAccent[400],
                blurRadius: 1.0,
                offset: Offset(0.3, 0.3),
              ),
              Shadow(
                color: Colors.blueAccent[400],
                blurRadius: 1.0,
                offset: Offset(-0.3, 0.3),
              ),
              Shadow(
                color: Colors.redAccent[400],
                blurRadius: 1.0,
                offset: Offset(0.3, -0.3),
              ),
            ]
        ),
        ),
        Icon(
          Icons.lock_rounded,
          color: Colors.pinkAccent[400],
          size: 35.0,
        ),
        ActionChip(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Colors.pinkAccent[400],
        padding: const EdgeInsets.all(2.0),
        onPressed: (){
          Navigator.pushNamed(context, '/Premium');
        },
        label: Text(
          'Obten Premium ahora',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
        ),
      ),
      ], 
    );
  }
}