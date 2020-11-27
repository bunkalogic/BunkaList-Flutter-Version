

import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/utils/get_top_id_from_key.dart';
import 'package:flutter/material.dart';



class ListSelectOfTypeTops extends StatefulWidget {

  final String type;
  

  ListSelectOfTypeTops({
    @required this.type,
  });

  @override
  _ListSelectOfTypeTopsState createState() => _ListSelectOfTypeTopsState();
}

class _ListSelectOfTypeTopsState extends State<ListSelectOfTypeTops> {
  
 
  
  
  final Preferences prefs = Preferences();  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (prefs.whatModeIs) ? Colors.black.withOpacity(0.87) : Colors.white.withOpacity(0.87),
      body: _listBuilderTypeOfTops(context),
      floatingActionButton: _fabCenter(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _listBuilderTypeOfTops(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.0, bottom: 55.0),
      child: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, i) => _listTypesTops(context, _getListTopsString(i), i),
      ),
    );
  }

  _fabCenter(BuildContext context) {
    return FloatingActionButton(
      elevation: 20.0,
      child: Icon(Icons.close),
      backgroundColor: Colors.purpleAccent[700],
      onPressed: (){
        final Map<String, dynamic> mapTopIdAndTitle = new Map();

        mapTopIdAndTitle.addAll({
          'topid'      : -1,
          'title'      : ''
        });

        Navigator.pop(context, mapTopIdAndTitle);
      }
    );
  }

  Widget _listTypesTops(BuildContext context, String title, int index) {
    return GestureDetector(
      onTap: () {
        final int topId = _getTopId(index);
        final Map<String, dynamic> mapTopIdAndTitle = new Map();

        mapTopIdAndTitle.addAll({
          'topid'      : topId,
          'title'      : title
        });  

        Navigator.pop(context, mapTopIdAndTitle);
        
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  String _getListTopsString(int index){

  // final List<String> moviesList = <String>[
  //    AppLocalizations.of(context).translate("movies_popular"),
  //    AppLocalizations.of(context).translate("movies_rated"),
  //    AppLocalizations.of(context).translate("movies_upcoming"),
  //    AppLocalizations.of(context).translate("movies_action"),
  //    AppLocalizations.of(context).translate("movies_adventure"), 
  //    AppLocalizations.of(context).translate("movies_comedy"),
  //    AppLocalizations.of(context).translate("movies_war"),
  //    AppLocalizations.of(context).translate("movies_scifi"),
  //    AppLocalizations.of(context).translate("movies_crime"),
  //    AppLocalizations.of(context).translate("movies_drama"),
  //    AppLocalizations.of(context).translate("movies_fantasy"),
  //    AppLocalizations.of(context).translate("movies_history"),
  //    AppLocalizations.of(context).translate("movies_mistery"),
  //    AppLocalizations.of(context).translate("movies_musical"),
  //    AppLocalizations.of(context).translate("movies_romance"),
  //    AppLocalizations.of(context).translate("movies_thiller"),
  //    AppLocalizations.of(context).translate("movies_terror"),
  //    AppLocalizations.of(context).translate("movies_western"),
  //    AppLocalizations.of(context).translate("movies_korean"),
  // ];

  final List<String> moviesList = <String>[
     AppLocalizations.of(context).translate("movies_popular"),
     AppLocalizations.of(context).translate("movies_rated"),
     AppLocalizations.of(context).translate("movies_upcoming"),
     AppLocalizations.of(context).translate("movies_history"),
     AppLocalizations.of(context).translate("movies_dystopia"),
     AppLocalizations.of(context).translate("movies_ww"),
     AppLocalizations.of(context).translate("movies_spacc_travel"),
     AppLocalizations.of(context).translate("movies_true_story"),
     AppLocalizations.of(context).translate("movies_cyberpunk"),
     AppLocalizations.of(context).translate("movies_conspiracy"),
     AppLocalizations.of(context).translate("movies_post_apocalytic"),
     AppLocalizations.of(context).translate("movies_time_travel"),
     AppLocalizations.of(context).translate("movies_lawyer"),
     AppLocalizations.of(context).translate("movies_serial_killer"),
     AppLocalizations.of(context).translate("movies_revenge"),
     
  ];

  final List<String> seriesList = <String>[
    AppLocalizations.of(context).translate("series_popular"),
    AppLocalizations.of(context).translate("series_rated"),
    AppLocalizations.of(context).translate("series_upcomming"),
    //AppLocalizations.of(context).translate("series_act_and_adv"),
    //AppLocalizations.of(context).translate("series_comedy"),
    //AppLocalizations.of(context).translate("series_crimen"),
    AppLocalizations.of(context).translate("series_documental"),
    //AppLocalizations.of(context).translate("series_family"),
    //AppLocalizations.of(context).translate("series_drama"),
    //AppLocalizations.of(context).translate("series_mistery"),
    //AppLocalizations.of(context).translate("series_fantasy_and_sci_fi"),
    //AppLocalizations.of(context).translate("series_war_and_politics"),
    //AppLocalizations.of(context).translate("series_western"),
    //AppLocalizations.of(context).translate("series_netflix"),
    //AppLocalizations.of(context).translate("series_hbo"),
    //AppLocalizations.of(context).translate("series_amazon_prime"),
    //AppLocalizations.of(context).translate("series_bbc_one"), 
    //AppLocalizations.of(context).translate("series_amc"),
    AppLocalizations.of(context).translate("series_korean"),
    AppLocalizations.of(context).translate("series_dystopia"),
    //AppLocalizations.of(context).translate("series_ww"),
    AppLocalizations.of(context).translate("series_spacc_travel"),
    AppLocalizations.of(context).translate("series_true_story"),
    AppLocalizations.of(context).translate("series_cyberpunk"),
    AppLocalizations.of(context).translate("series_conspiracy"),
    AppLocalizations.of(context).translate("series_post_apocalytic"),
    AppLocalizations.of(context).translate("series_time_travel"),
    AppLocalizations.of(context).translate("series_lawyer"),
    AppLocalizations.of(context).translate("series_serial_killer"),
    AppLocalizations.of(context).translate("series_revenge"),
  ];
  
  final List<String> animesList = <String>[
    AppLocalizations.of(context).translate("anime_popular"),
    AppLocalizations.of(context).translate("anime_rated"),
    AppLocalizations.of(context).translate("anime_season"),
    //AppLocalizations.of(context).translate("anime_upcoming_next_season"),
    AppLocalizations.of(context).translate("anime_action_and_adventure"),
    AppLocalizations.of(context).translate("anime_comedy"),
    //AppLocalizations.of(context).translate("anime_crimen"),
    AppLocalizations.of(context).translate("anime_drama"),
    //AppLocalizations.of(context).translate("anime_mistery"),
    AppLocalizations.of(context).translate("anime_fantasy_and_sci_fi"),
    //AppLocalizations.of(context).translate("anime_war_and_politics"),
    AppLocalizations.of(context).translate("anime_shonen"),
    AppLocalizations.of(context).translate("anime_spokon"),
    AppLocalizations.of(context).translate("anime_mecha"),
    AppLocalizations.of(context).translate("anime_slice_of_life"),
    AppLocalizations.of(context).translate("anime_based_on_manga"),
    AppLocalizations.of(context).translate("anime_romance"),
    AppLocalizations.of(context).translate("anime_super_natural"),
    AppLocalizations.of(context).translate("anime_seinen"),
  ]; 


    switch (widget.type) {
      case 'movies': {
        return moviesList[index];
        }
        break;

      case  'tv': { 
        return seriesList[index];
      }
        break;

      case  'animes': {
        return animesList[index];
        }
        break;

      default: return '';
    }
  }

  int _getTopId(int index) {
    print(index);
    if(widget.type == 'movies'){
      return GetTopIdFromKey().getTopIdFromMovie(index);

    }else if(widget.type == 'tv'){
      return GetTopIdFromKey().getTopIdFromSeries(index);

    }else if(widget.type == 'animes'){
      return GetTopIdFromKey().getTopIdFromAnimes(index);
      
    }
    return 1;
    
  }
}
