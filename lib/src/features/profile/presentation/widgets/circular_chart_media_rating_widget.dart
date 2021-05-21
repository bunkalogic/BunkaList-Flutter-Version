import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:flutter_circular_chart/flutter_circular_chart.dart';


class MediaRatingWidget extends StatefulWidget {
  final String type; 
  final ListProfileQuery status;

  const MediaRatingWidget({
    @required this.type,
    @required this.status
  });

  @override
  _MediaRatingWidgetState createState() => _MediaRatingWidgetState();
}

class _MediaRatingWidgetState extends State<MediaRatingWidget> {
  // final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  final Preferences prefs = Preferences();

  double ratingAverage = 0.0;

  Color chartColor;

  bool changeValue = false;  

  @override
  void initState() {
    BlocProvider.of<GetListsBloc>(context)..add(
      GetYourLists( type: widget.type, status: widget.status)
    );
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<GetListsBloc, GetListsState>(
      listener: (context, state) {
        if(state is GetListsLoaded){
         
         setState(() {
           ratingAverage = getMediaRating(state.ouevreList);
           changeValue = true;
         });
        }
      },
      child: roundedCircularRating()
    );
  }

  

  Widget roundedCircularRating(){
    switch(widget.type){
      
      case 'movie': return CircularMediaRatingList(color: Colors.redAccent[400], rating: ratingAverage, textColor: Colors.redAccent,); //_roundedCircularRatingMovie();

      case 'tv': return CircularMediaRatingList(color: Colors.greenAccent[400], rating: ratingAverage, textColor: Colors.greenAccent,); //_roundedCircularRatingSerie();

      case 'anime': return CircularMediaRatingList(color: Colors.lightBlueAccent[400], rating: ratingAverage, textColor: Colors.lightBlueAccent,); //_roundedCircularRatingAnime();

      default: return _roundedCircularRatingMovie();
    }
  }

  double getMediaRating(List<OuevreEntity> ouevres){
    //if(ouevres.isEmpty) return 0.0;  

    final List<double> listRating = [];

    for (var ouevre in ouevres) {
      listRating.add(ouevre.finalRate);  
    }

    double rateAverage = listRating.reduce((a, b) => a + b) / listRating.length;
    print('Rate average of ${widget.type} is $rateAverage');
    return rateAverage;
  }


  Widget _roundedCircularRatingMovie() {

    final double ratingRound = double.parse((ratingAverage).toStringAsFixed(2));

    final double rest = ratingAverage.toDouble() / 10;

  //   List<CircularStackEntry> nextData = <CircularStackEntry>[
  //     new CircularStackEntry(
  //       <CircularSegmentEntry>[
  //         new CircularSegmentEntry(
  //           ratingAverage,
  //           Colors.redAccent[400],
  //           rankKey: 'completed',
  //         ),
  //         new CircularSegmentEntry(
  //           rest,
  //           Colors.blueGrey[400],
  //           rankKey: 'remaining',
  //         ),
  //       ],
  //       rankKey: 'progress',
  //     ),
  //   ];
    
  //  if(changeValue){
  //     setState(() {
  //       _chartKey.currentState.updateData(nextData);
  //     });
  //   }

  //   return new AnimatedCircularChart(
  //     duration: Duration(milliseconds: 600),
  //     key: _chartKey,
  //     size: Size(70.0, 70.0), 
  //     initialChartData: nextData,
  //     chartType: CircularChartType.Radial,
  //     edgeStyle: SegmentEdgeStyle.round,
  //     holeRadius: 12.0,
  //     percentageValues: false,
  //     holeLabel: ratingAverage.toStringAsFixed(2),
  //     labelStyle: new TextStyle(
  //       fontWeight: FontWeight.w800,
  //       fontSize: 14.0,
  //       color: (prefs.whatModeIs) ? Colors.white : Colors.black,
  //     ),
  //   );

    return CircularPercentIndicator(
      percent: rest,
      radius: 65.0,
      animation: true,
      animationDuration: 600,
      lineWidth: 7.5,
      backgroundColor: Colors.blueGrey[600],
      progressColor: Colors.redAccent[400],
      center: Text(
        '$ratingRound',
        style: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 18.0,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 2.5,
            color: Colors.black,
          )
        ]
      ),
      ),
    );
  }

   Widget _roundedCircularRatingSerie() {

    final double ratingRound = double.parse((ratingAverage).toStringAsFixed(2));

    final double rest = ratingAverage.toDouble() / 10;

    

    // List<CircularStackEntry> nextData = <CircularStackEntry>[
    //   new CircularStackEntry(
    //     <CircularSegmentEntry>[
    //       new CircularSegmentEntry(
    //         ratingAverage,
    //         Colors.greenAccent[400],
    //         rankKey: 'completed',
    //       ),
    //       new CircularSegmentEntry(
    //         rest,
    //         Colors.blueGrey[400],
    //         rankKey: 'remaining',
    //       ),
    //     ],
    //     rankKey: 'progress',
    //   ),
    // ];
    
    // if(changeValue){
    //   setState(() {
    //     _chartKey.currentState.updateData(nextData);
    //   });
    // }
  
    
    // return new AnimatedCircularChart(
    //   duration: Duration(milliseconds: 600),
    //   key: _chartKey,
    //   size: Size(70.0, 70.0), 
    //   initialChartData: nextData,
    //   chartType: CircularChartType.Radial,
    //   edgeStyle: SegmentEdgeStyle.round,
    //   holeRadius: 12.0,
    //   percentageValues: false,
    //   holeLabel: ratingAverage.toStringAsFixed(2),
    //   labelStyle: new TextStyle(
    //     fontWeight: FontWeight.w800,
    //     fontSize: 14.0,
    //     color: (prefs.whatModeIs) ? Colors.white : Colors.black,
    //   ),
    // );

    return CircularPercentIndicator(
      percent: rest,
      radius: 65.0,
      animation: true,
      animationDuration: 600,
      lineWidth: 7.5,
      backgroundColor: Colors.blueGrey[600],
      progressColor: Colors.greenAccent[400],
      center: Text(
        '$ratingRound',
        style: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 18.0,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 2.5,
            color: Colors.black,
          )
        ]
      ),
      ),
    );
  }

  Widget _roundedCircularRatingAnime() {

    final double ratingRound = double.parse((ratingAverage).toStringAsFixed(2));

    final double rest = ratingAverage.toDouble() / 10;
    

    // List<CircularStackEntry> nextData = <CircularStackEntry>[
    //   new CircularStackEntry(
    //     <CircularSegmentEntry>[
    //       new CircularSegmentEntry(
    //         ratingAverage,
    //         Colors.lightBlueAccent[400],
    //         rankKey: 'completed',
    //       ),
    //       new CircularSegmentEntry(
    //         rest,
    //         Colors.blueGrey[400],
    //         rankKey: 'remaining',
    //       ),
    //     ],
    //     rankKey: 'progress',
    //   ),
    // ];
    
    //  if(changeValue){
    //   setState(() {
    //     _chartKey.currentState.updateData(nextData);
    //   });
    // }
    
    // return new AnimatedCircularChart(
    //   duration: Duration(milliseconds: 600),
    //   key: _chartKey,
    //   size: Size(70.0, 70.0), 
    //   initialChartData: nextData,
    //   chartType: CircularChartType.Radial,
    //   edgeStyle: SegmentEdgeStyle.round,
    //   holeRadius: 12.0,
    //   percentageValues: false,
    //   holeLabel: ratingAverage.toStringAsFixed(2),
    //   labelStyle: new TextStyle(
    //     fontWeight: FontWeight.w800,
    //     fontSize: 14.0,
    //     color: (prefs.whatModeIs) ? Colors.white : Colors.black,
    //   ),
    // );

    return CircularPercentIndicator(
      percent: rest,
      radius: 65.0,
      animation: true,
      animationDuration: 600,
      lineWidth: 7.5,
      backgroundColor: Colors.blueGrey[600],
      progressColor: Colors.blueAccent[400],
      center: Text(
        '$ratingRound',
        style: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 18.0,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 2.5,
            color: Colors.black,
          )
        ]
      ),
      ),
    );
  }
}


class CircularMediaRatingList extends StatefulWidget {

  final double rating;
  final Color color;
  final Color textColor;

  CircularMediaRatingList({
    @required this.rating,
    @required this.color,
    @required this.textColor
  });

  @override
  _CircularMediaRatingListState createState() => _CircularMediaRatingListState();
}

class _CircularMediaRatingListState extends State<CircularMediaRatingList> {
  @override
  Widget build(BuildContext context) {

    double ratingRound = double.parse((widget.rating).toStringAsFixed(2));

    final double rest = widget.rating.toDouble() / 10;

    return CircularPercentIndicator(
      percent: rest,
      radius: 50.0,
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 600,
      lineWidth: 6.5,
      backgroundColor: Colors.blueGrey[600],
      progressColor: widget.color,
      center: Text(
        '$ratingRound',
        style: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 16.0,
        color: widget.textColor,
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