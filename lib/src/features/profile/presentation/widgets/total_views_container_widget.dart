import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TotalViewsWidget extends StatefulWidget {

  final String type; 
  final String status;

  const TotalViewsWidget({
    @required this.type,
    @required this.status
  });

  @override
  _TotalViewsWidgetState createState() => _TotalViewsWidgetState();
}

class _TotalViewsWidgetState extends State<TotalViewsWidget> {


  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetListsBloc>(context)..add(
      GetYourLists( type: widget.type, status: widget.status)
    );
  }

  final loadingPage = Center(
      child: CircularProgressIndicator(),
    );

  @override
  Widget build(BuildContext context) {
    return Container(
       child:BlocBuilder<GetListsBloc, GetListsState>(
      builder: (context, state) {
        if(state is GetListsLoading){

          return loadingPage;

        }else if(state is GetListsLoaded){

          return Container(
            child: _columnTotalViewsWidget(context, state.ouevreList.length),
          );

        }else if(state is GetlistsError){

          return Center(
              child: Text('something Error'),
          );

        }

        return Center(
              child: Text('something Error'),
        );

      },
      ),
    );
  }

  Widget _columnTotalViewsWidget(BuildContext context, int totalViewsWidget){
    return Column(
      children: <Widget>[
        _labelTotalViewsWidget(context),
        SizedBox(height: 5.0,),
        _valueTotalViewsWidget(totalViewsWidget),
      ],
    );
  }

  Widget _valueTotalViewsWidget(int totalViewsWidget){
    return Text(
      '$totalViewsWidget',
      style: TextStyle(
        fontSize: 20.0, 
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic
      ),
    );
  }

  Widget _labelTotalViewsWidget(BuildContext context){
    return Text(
      _getLabelTotalViewsWidget(context),
      style: TextStyle(
        fontSize: 16.0, 
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic
      ),
    );
  }

  String _getLabelTotalViewsWidget(BuildContext context){
    switch(widget.type){
      
      case 'movie': return AppLocalizations.of(context).translate("total_movies");
      
      case 'tv': return AppLocalizations.of(context).translate("total_series");
      
      case 'anime': return AppLocalizations.of(context).translate("total_animes");
      
      default: return  'no data';
    }
  }
}