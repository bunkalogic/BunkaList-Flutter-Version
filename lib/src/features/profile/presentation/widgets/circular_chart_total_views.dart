import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ListContainerChartViews extends StatefulWidget {
  ListContainerChartViews({Key key}) : super(key: key);

  @override
  _ListContainerChartViewsState createState() => _ListContainerChartViewsState();
}

class _ListContainerChartViewsState extends State<ListContainerChartViews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.6,
      child: CarouselSlider(
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 1.8,
        initialPage: 1,
        items: <Widget>[
          _containerExample("label_total_chart_movie", 'movie'),
          _containerExample("label_total_chart_serie", 'tv'),
          _containerExample("label_total_chart_anime", 'anime')
        ],
      ),
    );
  }

  Widget _containerExample(String title, String type){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
      child: Container(
          child: _columnTitleAndCharts(title, type),   
          height: 160.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: [
                Colors.blueGrey[400].withOpacity(0.15),
                Colors.blueGrey[400].withOpacity(0.15),
                Colors.blueGrey[400].withOpacity(0.15),
                Colors.blueGrey[400].withOpacity(0.15)
              ]
            ) 
          ),
        ),
    );
  }

  Widget _columnTitleAndCharts(String title, String type) {
    return Column(
      children: <Widget>[
        _labelProfileChartTotal(title),
        new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: ChartsTotalByStatus(type: type,),
          ),
        
      ],
    );
  }

  Widget _labelProfileChartTotal(String title){
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        AppLocalizations.of(context).translate(title),
        textAlign: TextAlign.center,
        style: TextStyle(
        fontSize: 18.0, 
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic
      ),
      ),
    );
  }
}


class ChartsTotalByStatus extends StatefulWidget {
  final String type; 

  const ChartsTotalByStatus({
    @required this.type,
  });

  @override
  _ChartsTotalByStatusState createState() => _ChartsTotalByStatusState();
}

class _ChartsTotalByStatusState extends State<ChartsTotalByStatus> {

  Preferences prefs = Preferences();
  List<TotalByStatus> data = new List<TotalByStatus>();

  @override
  void initState() {
    BlocProvider.of<GetListsBloc>(context)..add(
      GetTotalByStatusEvent( type: widget.type,)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   

    return BlocListener<GetListsBloc, GetListsState>(
      listener: (context, state) {
        if(state is GetTotalByStatusLoaded){
          
           data = [
            new TotalByStatus(AppLocalizations.of(context).translate("status_completed"),state.listTotalByStatus[0] ),
            new TotalByStatus(AppLocalizations.of(context).translate("status_watching"), state.listTotalByStatus[1] ),
            new TotalByStatus(AppLocalizations.of(context).translate("status_pause"),    state.listTotalByStatus[2] ),
            new TotalByStatus(AppLocalizations.of(context).translate("status_dropped"),  state.listTotalByStatus[3] ),
            new TotalByStatus(AppLocalizations.of(context).translate("status_wishlist"), state.listTotalByStatus[4] ),
          ];
          setState(() {});
        }
      },
      child: Container(
        height: 155.0,
         child: charts.BarChart(
          _createSampleData(context),
          animate: true,
          vertical: false,
          primaryMeasureAxis:
            new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
          domainAxis: new charts.OrdinalAxisSpec(
            // Make sure that we draw the domain axis line.
            showAxisLine: true,
            // But don't draw anything else.
            renderSpec: new charts.NoneRenderSpec()
          ),
          barRendererDecorator: new charts.BarLabelDecorator(
            insideLabelStyleSpec: new charts.TextStyleSpec(color: charts.Color.white, fontSize: 14, ),
            outsideLabelStyleSpec: new charts.TextStyleSpec(color: (prefs.whatModeIs) ? charts.Color.white : charts.Color.black,fontSize: 14, )
          ),
        ),
      )
    );

    
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<TotalByStatus, String>> _createSampleData(BuildContext context, ) {
    List<TotalByStatus> listNull = [
      new TotalByStatus(AppLocalizations.of(context).translate("status_completed"),0 ),
      new TotalByStatus(AppLocalizations.of(context).translate("status_watching"), 0 ),
      new TotalByStatus(AppLocalizations.of(context).translate("status_pause"),    0 ),
      new TotalByStatus(AppLocalizations.of(context).translate("status_dropped"),  0 ),
      new TotalByStatus(AppLocalizations.of(context).translate("status_wishlist"), 0 ),
    ];

    return [
      new charts.Series<TotalByStatus, String>(
          id: 'status',
          domainFn: (TotalByStatus status, _) => status.status,
          measureFn: (TotalByStatus status, _) => status.count,
          data: (data.isEmpty) ? listNull : data,
          colorFn: (TotalByStatus status, i) => getStatusColor(i),
          labelAccessorFn: (TotalByStatus status, _) =>
              '${status.status}: ${status.count.toString()}'
      )
    ];
  }

  charts.Color getStatusColor(int position){
    switch (position) {
      case 0: return charts.ColorUtil.fromDartColor(Colors.greenAccent[400]);
        break;

      case 1: return charts.ColorUtil.fromDartColor(Colors.blueAccent[400]);
        break;

      case 2: return charts.ColorUtil.fromDartColor(Colors.deepOrangeAccent[400]);
        break;

      case 3: return charts.ColorUtil.fromDartColor(Colors.redAccent[400]);
        break;

      case 4: return charts.ColorUtil.fromDartColor(Colors.deepPurpleAccent[400]);
        break;  


      default: return charts.ColorUtil.fromDartColor(Colors.greenAccent[400]);
    }
  }
  

}

/// data type.
class TotalByStatus {
  final String status;
  final int count;

  TotalByStatus(this.status, this.count);
}





