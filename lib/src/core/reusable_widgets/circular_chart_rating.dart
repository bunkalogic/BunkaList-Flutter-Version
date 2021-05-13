import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MiniCircularChartRating extends StatefulWidget {
  final double rating;
  
  MiniCircularChartRating(this.rating);

  @override
  _MiniCircularChartRatingState createState() => _MiniCircularChartRatingState();
}
class _MiniCircularChartRatingState extends State<MiniCircularChartRating> {

  //final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  final Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: circularPercentIndicator()
      // child: _roundedCircularRating(),
    );
  }

  // Widget _roundedCircularRating() {
  //   final double rest = 10 - widget.rating;
    


  //   return new AnimatedCircularChart(
  //     key: _chartKey,
  //     size: Size(50.0, 50.0), 
  //     initialChartData: <CircularStackEntry>[
  //       new CircularStackEntry(
  //       <CircularSegmentEntry>[
  //         new CircularSegmentEntry(
  //           widget.rating,
  //           Colors.pinkAccent[400],
  //           rankKey: 'completed',
  //         ),
  //         new CircularSegmentEntry(
  //           rest,
  //           Colors.blueGrey[600],
  //           rankKey: 'remaining',
  //         ),
  //       ],
  //       rankKey: 'progress',
  //     ),
  //     ],
  //     chartType: CircularChartType.Radial,
  //     edgeStyle: SegmentEdgeStyle.round,
  //     holeRadius: 13.0,
  //     percentageValues: false,
  //     holeLabel: widget.rating.toString(),
  //     labelStyle: new TextStyle(
  //       fontWeight: FontWeight.w800,
  //       fontSize: 14.0,
  //       color: Colors.white,
  //       shadows: [
  //         Shadow(
  //           blurRadius: 2.5,
  //           color: Colors.black,
  //         )
  //       ]
  //     ),
  //   );
  // }

  Widget circularPercentIndicator(){

    double percent = widget.rating / 10;

    return CircularPercentIndicator(
      percent: percent,
      radius: 40.0,
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 600,
      lineWidth: 4.6,
      backgroundColor: Colors.blueGrey[600],
      progressColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
      // linearGradient: LinearGradient(
        
      //   tileMode: TileMode.clamp,
      //   stops: [0, 0.2, 0.3, 0.4, 0.6,  0.7, 0.8, 1.0],
      //   colors: [
      //     Colors.pinkAccent[700],
      //     Colors.pinkAccent[400],
      //     Colors.pink,
      //     Colors.pink[700],
      //     Colors.deepPurple[700],
      //     Colors.deepPurple,
      //     Colors.deepPurpleAccent[400],
      //     Colors.deepPurpleAccent[700],
      //   ]
      // ),
      center: Text(
        '${widget.rating}',
        style: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 16.0,
        color: prefs.whatModeIs ? Colors.pinkAccent : Colors.deepPurpleAccent,
        shadows: [
          Shadow(
            blurRadius: 0.5,
            color: Colors.black,
          )
        ]
      ),
      ),
    );
  }
}


class BigCircularChartRating extends StatefulWidget {
  final double rating;
  
  BigCircularChartRating(this.rating);

  @override
  _BigCircularChartRatingState createState() => _BigCircularChartRatingState();
}
class _BigCircularChartRatingState extends State<BigCircularChartRating> {

  // final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  final Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return circularPercentIndicator();
  }

  // Widget _roundedCircularRating() {
  //   final double rest = 10 - widget.rating;
    


  //   return new AnimatedCircularChart(
  //     key: _chartKey,
  //     size: Size(70.0, 70.0), 
  //     initialChartData: <CircularStackEntry>[
  //       new CircularStackEntry(
  //       <CircularSegmentEntry>[
  //         new CircularSegmentEntry(
  //           widget.rating,
  //           Colors.pinkAccent[400],
  //           rankKey: 'completed',
  //         ),
  //         new CircularSegmentEntry(
  //           rest,
  //           Colors.blueGrey[600],
  //           rankKey: 'remaining',
  //         ),
  //       ],
  //       rankKey: 'progress',
  //     ),
  //     ],
  //     chartType: CircularChartType.Radial,
  //     edgeStyle: SegmentEdgeStyle.round,
  //     holeRadius: 15.0,
  //     percentageValues: false,
  //     holeLabel: widget.rating.toString(),
  //     labelStyle: new TextStyle(
  //       fontWeight: FontWeight.w700,
  //       fontSize: 18.0,
  //       color: (prefs.whatModeIs) ? Colors.white : Colors.black,
  //       shadows: (prefs.whatModeIs) 
  //       ? [
  //         Shadow(
  //           blurRadius: 2.5,
  //           color: Colors.black,
  //         )
  //       ]
  //       : [
  //         Shadow(
  //           blurRadius: 2.5,
  //           color: Colors.white,
  //         )
  //       ]
  //     ),
  //   );
  // }

  Widget circularPercentIndicator(){

    double percent = widget.rating / 10;

    return CircularPercentIndicator(
      percent: percent,
      radius: 50.0,
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
      animationDuration: 600,
      lineWidth: 7.0,
      backgroundColor: Colors.blueGrey[600],
      progressColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
      // linearGradient: LinearGradient(
        
      //   tileMode: TileMode.clamp,
      //   stops: [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0],
      //   colors: [
      //     Colors.pinkAccent[700],
      //     Colors.pinkAccent[400],
      //     Colors.pink[400],
      //     Colors.pink[500],
      //     Colors.pink[600],
      //     Colors.pink[700],
      //     Colors.deepPurple[700],
      //     Colors.deepPurple[600],
      //     Colors.deepPurple[500],
      //     Colors.deepPurpleAccent[400],
      //     Colors.deepPurpleAccent[700],
      //   ]
      // ),
      center: Text(
        '${widget.rating}',
        style: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 18.0,
        color:  prefs.whatModeIs ? Colors.pinkAccent : Colors.deepPurpleAccent,
        shadows: [
          Shadow(
            blurRadius: 0.5,
            color: Colors.black,
          )
        ]
      ),
      ),
    );
  }
}

class BigFavoriteCircularChartRating extends StatefulWidget {
  final double rating;
  
  BigFavoriteCircularChartRating(this.rating);

  @override
  _BigFavoriteCircularChartRatingState createState() => _BigFavoriteCircularChartRatingState();
}
class _BigFavoriteCircularChartRatingState extends State<BigFavoriteCircularChartRating> {

  // final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  final Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return  circularPercentIndicator();
  }

  // Widget _roundedCircularRating() {
  //   final double rest = 10 - widget.rating;
    


  //   return new AnimatedCircularChart(
  //     key: _chartKey,
  //     size: Size(60.0, 60.0), 
  //     initialChartData: <CircularStackEntry>[
  //       new CircularStackEntry(
  //       <CircularSegmentEntry>[
  //         new CircularSegmentEntry(
  //           widget.rating,
  //           Colors.amberAccent[400],
  //           rankKey: 'completed',
  //         ),
  //         new CircularSegmentEntry(
  //           rest,
  //           Colors.blueGrey[600],
  //           rankKey: 'remaining',
  //         ),
  //       ],
  //       rankKey: 'progress',
  //     ),
  //     ],
  //     chartType: CircularChartType.Radial,
  //     edgeStyle: SegmentEdgeStyle.round,
  //     holeRadius: 12.0,
  //     percentageValues: false,
  //     holeLabel: widget.rating.toString(),
  //     labelStyle: new TextStyle(
  //       fontWeight: FontWeight.w700,
  //       fontSize: 16.0,
  //       color: Colors.white,
  //       shadows:  [
  //         Shadow(
  //           blurRadius: 2.5,
  //           color: Colors.black,
  //         )
  //       ]
  //     ),
  //   );
  // }

  Widget circularPercentIndicator(){

    double percent = widget.rating / 10;

    return CircularPercentIndicator(
      percent: percent,
      radius: 45.0,
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
      animationDuration: 600,
      lineWidth: 5.5,
      backgroundColor: Colors.blueGrey[600],
      progressColor: Colors.amberAccent[400],
      // linearGradient: LinearGradient(
        
      //   tileMode: TileMode.clamp,
      //   stops: [0, 0.2, 0.3, 0.4, 0.6,  0.7, 0.8, 1.0],
      //   colors: [
      //     Colors.pinkAccent[700],
      //     Colors.pinkAccent[400],
      //     Colors.pink,
      //     Colors.pink[700],
      //     Colors.deepPurple[700],
      //     Colors.deepPurple,
      //     Colors.deepPurpleAccent[400],
      //     Colors.deepPurpleAccent[700],
      //   ]
      // ),
      center: Text(
        '${widget.rating}',
        style: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 16.0,
        color: Colors.amberAccent,
        shadows: [
          Shadow(
            blurRadius: 0.5,
            color: Colors.black,
          )
        ]
      ),
      ),
    );
  }
}

class MiniFavoriteCircularChartRating extends StatefulWidget {
  final double rating;
  
  MiniFavoriteCircularChartRating(this.rating);

  @override
  _MiniFavoriteCircularChartRatingState createState() => _MiniFavoriteCircularChartRatingState();
}
class _MiniFavoriteCircularChartRatingState extends State<MiniFavoriteCircularChartRating> {

  // final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  final Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return circularPercentIndicator();
  }

  // Widget _roundedCircularRating() {
  //   final double rest = 10 - widget.rating;
    


  //   return new AnimatedCircularChart(
  //     key: _chartKey,
  //     size: Size(50.0, 50.0), 
  //     initialChartData: <CircularStackEntry>[
  //       new CircularStackEntry(
  //       <CircularSegmentEntry>[
  //         new CircularSegmentEntry(
  //           widget.rating,
  //           Colors.amberAccent[400],
  //           rankKey: 'completed',
  //         ),
  //         new CircularSegmentEntry(
  //           rest,
  //           Colors.blueGrey[600],
  //           rankKey: 'remaining',
  //         ),
  //       ],
  //       rankKey: 'progress',
  //     ),
  //     ],
  //     chartType: CircularChartType.Radial,
  //     edgeStyle: SegmentEdgeStyle.round,
  //     holeRadius: 13.0,
  //     percentageValues: false,
  //     holeLabel: widget.rating.toString(),
  //     labelStyle: new TextStyle(
  //       fontWeight: FontWeight.w800,
  //       fontSize: 14.0,
  //       color: Colors.white,
  //       shadows:  [
  //         Shadow(
  //           blurRadius: 2.5,
  //           color: Colors.black,
  //         )
  //       ]
  //     ),
  //   );
  // }

  Widget circularPercentIndicator(){

    double percent = widget.rating / 10;

    return CircularPercentIndicator(
      percent: percent,
      radius: 40.0,
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 600,
      lineWidth: 4.6,
      backgroundColor: Colors.blueGrey[600],
      progressColor: Colors.amberAccent[400],
      // linearGradient: LinearGradient(
        
      //   tileMode: TileMode.clamp,
      //   stops: [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0],
      //   colors: [
      //     Colors.pinkAccent[700],
      //     Colors.pinkAccent[400],
      //     Colors.pink[400],
      //     Colors.pink[500],
      //     Colors.pink[600],
      //     Colors.pink[700],
      //     Colors.deepPurple[700],
      //     Colors.deepPurple[600],
      //     Colors.deepPurple[500],
      //     Colors.deepPurpleAccent[400],
      //     Colors.deepPurpleAccent[700],
      //   ]
      // ),
      center: Text(
        '${widget.rating}',
        style: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 16.0,
        color: Colors.amberAccent,
        shadows: [
          Shadow(
            blurRadius: 0.5,
            color: Colors.black,
          )
        ]
      ),
      ),
    );
  }
}

class MiniCircularChartRatingColor extends StatefulWidget {
  final double rating;
  final Color color;
  MiniCircularChartRatingColor(this.rating, this.color);

  @override
  _MiniCircularChartRatingColorState createState() => _MiniCircularChartRatingColorState();
}
class _MiniCircularChartRatingColorState extends State<MiniCircularChartRatingColor> {

  // final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  final Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: circularPercentIndicator(),
    );
  }

  // Widget _roundedCircularRating() {
  //   final double rest = 10 - widget.rating;
    


  //   return new AnimatedCircularChart(
  //     key: _chartKey,
  //     size: Size(50.0, 50.0), 
  //     initialChartData: <CircularStackEntry>[
  //       new CircularStackEntry(
  //       <CircularSegmentEntry>[
  //         new CircularSegmentEntry(
  //           widget.rating,
  //           widget.color,
  //           rankKey: 'completed',
  //         ),
  //         new CircularSegmentEntry(
  //           rest,
  //           Colors.blueGrey[600],
  //           rankKey: 'remaining',
  //         ),
  //       ],
  //       rankKey: 'progress',
  //     ),
  //     ],
  //     chartType: CircularChartType.Radial,
  //     edgeStyle: SegmentEdgeStyle.round,
  //     holeRadius: 13.0,
  //     percentageValues: false,
  //     holeLabel: widget.rating.toString(),
  //     labelStyle: new TextStyle(
  //       fontWeight: FontWeight.w800,
  //       fontSize: 14.0,
  //       color: (prefs.whatModeIs) ? Colors.white : Colors.black,
  //       shadows: (prefs.whatModeIs) 
  //       ? [
  //         Shadow(
  //           blurRadius: 2.5,
  //           color: Colors.black,
  //         )
  //       ]
  //       : [
  //         Shadow(
  //           blurRadius: 2.5,
  //           color: Colors.white,
  //         )
  //       ]
  //     ),
  //   );
  // }

  Widget circularPercentIndicator(){

    double percent = widget.rating / 10;

    return CircularPercentIndicator(
      percent: percent,
      radius: 55.0,
      animation: true,
      animationDuration: 600,
      circularStrokeCap: CircularStrokeCap.round,
      lineWidth: 7.5,
      backgroundColor: Colors.blueGrey[600],
      progressColor: widget.color,
      // linearGradient: LinearGradient(
        
      //   tileMode: TileMode.clamp,
      //   stops: [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0],
      //   colors: [
      //     Colors.pinkAccent[700],
      //     Colors.pinkAccent[400],
      //     Colors.pink[400],
      //     Colors.pink[500],
      //     Colors.pink[600],
      //     Colors.pink[700],
      //     Colors.deepPurple[700],
      //     Colors.deepPurple[600],
      //     Colors.deepPurple[500],
      //     Colors.deepPurpleAccent[400],
      //     Colors.deepPurpleAccent[700],
      //   ]
      // ),
      center: Text(
        '${widget.rating}',
        style: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 18.0,
        color: widget.color,
      ),
      ),
    );
  }
}