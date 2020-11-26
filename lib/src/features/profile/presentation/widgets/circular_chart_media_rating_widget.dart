import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';


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
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

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
      
      case 'movie': return _roundedCircularRatingMovie();

      case 'tv': return _roundedCircularRatingSerie();

      case 'anime': return _roundedCircularRatingAnime();

      default: return _roundedCircularRatingMovie();
    }
  }

  double getMediaRating(List<OuevreEntity> ouevres){
    //if(ouevres.isEmpty) return 0.0;  

    final List<double> listRating = new List<double>();

    for (var ouevre in ouevres) {
      listRating.add(ouevre.finalRate);  
    }

    double rateAverage = listRating.reduce((a, b) => a + b) / listRating.length;
    print('Rate average of ${widget.type} is $rateAverage');
    return rateAverage;
  }


  Widget _roundedCircularRatingMovie() {
    final double rest = 10 - ratingAverage.toDouble();

    List<CircularStackEntry> nextData = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            ratingAverage,
            Colors.redAccent[400],
            rankKey: 'completed',
          ),
          new CircularSegmentEntry(
            rest,
            Colors.blueGrey[400],
            rankKey: 'remaining',
          ),
        ],
        rankKey: 'progress',
      ),
    ];
    
   if(changeValue){
      setState(() {
        _chartKey.currentState.updateData(nextData);
      });
    }

    return new AnimatedCircularChart(
      duration: Duration(milliseconds: 600),
      key: _chartKey,
      size: Size(70.0, 70.0), 
      initialChartData: nextData,
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      holeRadius: 14.0,
      percentageValues: false,
      holeLabel: ratingAverage.toStringAsFixed(2),
      labelStyle: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 14.0,
        color: (prefs.whatModeIs) ? Colors.white : Colors.black,
      ),
    );
  }

   Widget _roundedCircularRatingSerie() {
    final double rest = 10 - ratingAverage.toDouble();

    List<CircularStackEntry> nextData = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            ratingAverage,
            Colors.greenAccent[400],
            rankKey: 'completed',
          ),
          new CircularSegmentEntry(
            rest,
            Colors.blueGrey[400],
            rankKey: 'remaining',
          ),
        ],
        rankKey: 'progress',
      ),
    ];
    
    if(changeValue){
      setState(() {
        _chartKey.currentState.updateData(nextData);
      });
    }
  
    
    return new AnimatedCircularChart(
      duration: Duration(milliseconds: 600),
      key: _chartKey,
      size: Size(70.0, 70.0), 
      initialChartData: nextData,
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      holeRadius: 14.0,
      percentageValues: false,
      holeLabel: ratingAverage.toStringAsFixed(2),
      labelStyle: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 14.0,
        color: (prefs.whatModeIs) ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _roundedCircularRatingAnime() {
    final double rest = 10 - ratingAverage.toDouble();

    List<CircularStackEntry> nextData = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            ratingAverage,
            Colors.lightBlueAccent[400],
            rankKey: 'completed',
          ),
          new CircularSegmentEntry(
            rest,
            Colors.blueGrey[400],
            rankKey: 'remaining',
          ),
        ],
        rankKey: 'progress',
      ),
    ];
    
     if(changeValue){
      setState(() {
        _chartKey.currentState.updateData(nextData);
      });
    }
    
    return new AnimatedCircularChart(
      duration: Duration(milliseconds: 600),
      key: _chartKey,
      size: Size(70.0, 70.0), 
      initialChartData: nextData,
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      holeRadius: 14.0,
      percentageValues: false,
      holeLabel: ratingAverage.toStringAsFixed(2),
      labelStyle: new TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 14.0,
        color: (prefs.whatModeIs) ? Colors.white : Colors.black,
      ),
    );
  }
}