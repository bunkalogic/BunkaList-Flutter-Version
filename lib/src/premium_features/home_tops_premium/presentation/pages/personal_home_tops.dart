import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/entities/filter_entity.dart';
import 'package:flutter/material.dart';

import 'package:bunkalist/src/premium_features/home_tops_premium/presentation/widgets/build_list_personal_home_tops.dart';


class PersonalHomeTops extends StatefulWidget {
  PersonalHomeTops({Key key}) : super(key: key);

  @override
  _PersonalHomeTopsState createState() => _PersonalHomeTopsState();
}

class _PersonalHomeTopsState extends State<PersonalHomeTops> {
  
  final Preferences prefs = Preferences();

  
  @override
  Widget build(BuildContext context) {

    if(prefs.isNewUserPremium){
      _isNewUserPremium();
    }

    return Scaffold(
      body: buildListView(),
    );
  }

  ListView buildListView() {
    return ListView(
    children: [
      SizedBox(height: 10.0,),
      BuildListPersonalHomeTops(filterParams: FilterParams.fromJson(prefs.getHomeTops1),),
      SizedBox(height: 10.0,),
      BuildListPersonalHomeTops(filterParams: FilterParams.fromJson(prefs.getHomeTops2),),
      SizedBox(height: 10.0,),
      BuildListPersonalHomeTops(filterParams: FilterParams.fromJson(prefs.getHomeTops3),),
      SizedBox(height: 10.0,),
      BuildListPersonalHomeTops(filterParams: FilterParams.fromJson(prefs.getHomeTops4),),
      SizedBox(height: 10.0,),
      BuildListPersonalHomeTops(filterParams: FilterParams.fromJson(prefs.getHomeTops5),),
      SizedBox(height: 10.0,),
      BuildListPersonalHomeTops(filterParams: FilterParams.fromJson(prefs.getHomeTops6,)),
      SizedBox(height: 10.0,),
      BuildListPersonalHomeTops(filterParams: FilterParams.fromJson(prefs.getHomeTops7),),
      SizedBox(height: 10.0,),
      BuildListPersonalHomeTops(filterParams: FilterParams.fromJson(prefs.getHomeTops8),),
      SizedBox(height: 10.0,),
      BuildListPersonalHomeTops(filterParams: FilterParams.fromJson(prefs.getHomeTops9),),
      SizedBox(height: 15.0,),
    ],
  );
  }

  void _isNewUserPremium(){

    prefs.getHomeTops1 = new FilterParams(
      title: AppLocalizations.of(context).translate("movies_popular"),
      type: 'movie',
      sortBy: ConstSortBy.popularityDesc,
      design: false,
    );

    prefs.getHomeTops2 = new FilterParams(
      title: AppLocalizations.of(context).translate("label_movie_cinema"),
      type: 'movie',
      year: 2021,
      sortBy: ConstSortBy.popularityDesc,
      design: true,
    );

    prefs.getHomeTops3 = new FilterParams(
      title: AppLocalizations.of(context).translate("movies_rated"),
      type: 'movie',
      sortBy: ConstSortBy.voteCountDesc,
      design: false,
    );

    prefs.getHomeTops4 = new FilterParams(
      title: AppLocalizations.of(context).translate("series_popular"),
      type: 'tv',
      sortBy: ConstSortBy.popularityDesc,
      design: false,
    );

    prefs.getHomeTops5 = new FilterParams(
      title: AppLocalizations.of(context).translate("label_serie_month"),
      type: 'tv',
      year: 2021,
      sortBy: ConstSortBy.popularityDesc,
      design: true,
    );

    prefs.getHomeTops6 = new FilterParams(
      title: AppLocalizations.of(context).translate("series_rated"),
      type: 'tv',
      sortBy: ConstSortBy.voteCountDesc,
      design: false,
    );

    
    prefs.getHomeTops7 = new FilterParams(
      title: AppLocalizations.of(context).translate("anime_popular"),
      type: 'anime',
      sortBy: ConstSortBy.popularityDesc,
      design: false,
    );

    prefs.getHomeTops8 = new FilterParams(
      title: AppLocalizations.of(context).translate("label_anime_season"),
      type: 'anime',
      year: 2021,
      sortBy: ConstSortBy.popularityDesc,
      design: true,
    );

    prefs.getHomeTops9 = new FilterParams(
      title: AppLocalizations.of(context).translate("anime_rated"),
      type: 'anime',
      sortBy: ConstSortBy.voteCountDesc,
      design: false,
    );


    prefs.isNewUserPremium = false;
  }
}