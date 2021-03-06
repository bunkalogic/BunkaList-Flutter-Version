import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TotalViewsWidget extends StatefulWidget {

  final String type; 
  final ListProfileQuery status;

  const TotalViewsWidget({
    @required this.type,
    @required this.status
  });

  @override
  _TotalViewsWidgetState createState() => _TotalViewsWidgetState();
}

class _TotalViewsWidgetState extends State<TotalViewsWidget> {

  Preferences prefs = Preferences();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetListsBloc>(context)..add(
      GetYourLists( type: widget.type, status: widget.status)
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            _labelTotalViewsWidget(context),
            SizedBox(height: 5.0,),
            _valueTotalViewsWidget(),
          ],
        ),
      ),
    );
  }

  

  Widget _valueTotalViewsWidget(){
    return Container(
       child:BlocBuilder<GetListsBloc, GetListsState>(
      builder: (context, state) {
        if(state is GetListsLoading){
          return Center(
              child: Text('--'),
          );
        } else if(state is GetListsLoaded){

        _getIds(state.ouevreList);

        return Text(
        '${state.ouevreList.length}',
        style: TextStyle(
          fontSize: 22.0, 
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic
        ),
    );

        }else if(state is GetlistsError){

          return Center(
              child: Text('Error'),
          );

        }

        return Center(
              child: Text('--'),
        );

      },
      ),
    );
  }

  Widget _labelTotalViewsWidget(BuildContext context){
    return Text(
      _getLabelTotalViewsWidget(context),
      overflow: TextOverflow.ellipsis,
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


  void _getIds(List<OuevreEntity> ouevreList){

    if(widget.type == 'movie'){

      List<String> listMovie = ouevreList.map((e) => e.oeuvreId.toString()).toList();

      prefs.listMoviesIds = listMovie;
    }

    if(widget.type == 'tv'){

       List<String> listSerie = ouevreList.map((e) => e.oeuvreId.toString()).toList();


      prefs.listSerieIds = listSerie;
    }

    if(widget.type == 'anime'){

      List<String> listAnime = ouevreList.map((e) => e.oeuvreId.toString()).toList();


      prefs.listAnimeIds = listAnime;

    }
  }
}