import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class MiniCircularChartRating extends StatefulWidget {
  final double rating;
  
  MiniCircularChartRating(this.rating);

  @override
  _MiniCircularChartRatingState createState() => _MiniCircularChartRatingState();
}
class _MiniCircularChartRatingState extends State<MiniCircularChartRating> {

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  final Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: _roundedCircularRating(),
    );
  }

  Widget _roundedCircularRating() {
    final double rest = 10 - widget.rating;
    


    return new AnimatedCircularChart(
      key: _chartKey,
      size: Size(50.0, 50.0), 
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            widget.rating,
            Colors.pinkAccent[400],
            rankKey: 'completed',
          ),
          new CircularSegmentEntry(
            rest,
            Colors.blueGrey[600],
            rankKey: 'remaining',
          ),
        ],
        rankKey: 'progress',
      ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      holeRadius: 13.0,
      percentageValues: false,
      holeLabel: widget.rating.toString(),
      labelStyle: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 14.0,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 2.5,
            color: Colors.black,
          )
        ]
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

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  final Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return _roundedCircularRating();
  }

  Widget _roundedCircularRating() {
    final double rest = 10 - widget.rating;
    


    return new AnimatedCircularChart(
      key: _chartKey,
      size: Size(70.0, 70.0), 
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            widget.rating,
            Colors.pinkAccent[400],
            rankKey: 'completed',
          ),
          new CircularSegmentEntry(
            rest,
            Colors.blueGrey[600],
            rankKey: 'remaining',
          ),
        ],
        rankKey: 'progress',
      ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      holeRadius: 15.0,
      percentageValues: false,
      holeLabel: widget.rating.toString(),
      labelStyle: new TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
        color: (prefs.whatModeIs) ? Colors.white : Colors.black,
        shadows: (prefs.whatModeIs) 
        ? [
          Shadow(
            blurRadius: 2.5,
            color: Colors.black,
          )
        ]
        : [
          Shadow(
            blurRadius: 2.5,
            color: Colors.white,
          )
        ]
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

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  final Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return _roundedCircularRating();
  }

  Widget _roundedCircularRating() {
    final double rest = 10 - widget.rating;
    


    return new AnimatedCircularChart(
      key: _chartKey,
      size: Size(60.0, 60.0), 
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            widget.rating,
            Colors.amberAccent[400],
            rankKey: 'completed',
          ),
          new CircularSegmentEntry(
            rest,
            Colors.blueGrey[600],
            rankKey: 'remaining',
          ),
        ],
        rankKey: 'progress',
      ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      holeRadius: 12.0,
      percentageValues: false,
      holeLabel: widget.rating.toString(),
      labelStyle: new TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        color: Colors.white,
        shadows:  [
          Shadow(
            blurRadius: 2.5,
            color: Colors.black,
          )
        ]
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

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  final Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return _roundedCircularRating();
  }

  Widget _roundedCircularRating() {
    final double rest = 10 - widget.rating;
    


    return new AnimatedCircularChart(
      key: _chartKey,
      size: Size(50.0, 50.0), 
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            widget.rating,
            Colors.amberAccent[400],
            rankKey: 'completed',
          ),
          new CircularSegmentEntry(
            rest,
            Colors.blueGrey[600],
            rankKey: 'remaining',
          ),
        ],
        rankKey: 'progress',
      ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      holeRadius: 13.0,
      percentageValues: false,
      holeLabel: widget.rating.toString(),
      labelStyle: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 14.0,
        color: Colors.white,
        shadows:  [
          Shadow(
            blurRadius: 2.5,
            color: Colors.black,
          )
        ]
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

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  final Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: _roundedCircularRating(),
    );
  }

  Widget _roundedCircularRating() {
    final double rest = 10 - widget.rating;
    


    return new AnimatedCircularChart(
      key: _chartKey,
      size: Size(50.0, 50.0), 
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            widget.rating,
            widget.color,
            rankKey: 'completed',
          ),
          new CircularSegmentEntry(
            rest,
            Colors.blueGrey[600],
            rankKey: 'remaining',
          ),
        ],
        rankKey: 'progress',
      ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      holeRadius: 13.0,
      percentageValues: false,
      holeLabel: widget.rating.toString(),
      labelStyle: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 14.0,
        color: (prefs.whatModeIs) ? Colors.white : Colors.black,
        shadows: (prefs.whatModeIs) 
        ? [
          Shadow(
            blurRadius: 2.5,
            color: Colors.black,
          )
        ]
        : [
          Shadow(
            blurRadius: 2.5,
            color: Colors.white,
          )
        ]
      ),
    );
  }
}