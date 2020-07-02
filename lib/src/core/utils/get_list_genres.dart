

import 'package:bunkalist/src/core/constans/constans_genres_id.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

List<Genres> getListGenresMovies(BuildContext context){
  
  List<String> listGenresLabel = [
    AppLocalizations.of(context).translate("genre_action"),     
    AppLocalizations.of(context).translate("genre_adventure"),  
    AppLocalizations.of(context).translate("genre_animation"),  
    AppLocalizations.of(context).translate("genre_comedy"),     
    AppLocalizations.of(context).translate("genre_crime"),      
    AppLocalizations.of(context).translate("genre_documentary"),
    AppLocalizations.of(context).translate("genre_drama"),      
    AppLocalizations.of(context).translate("genre_family"),     
    AppLocalizations.of(context).translate("genre_fantasy"),    
    AppLocalizations.of(context).translate("genre_history"),    
    AppLocalizations.of(context).translate("genre_horror"),     
    AppLocalizations.of(context).translate("genre_mistery"),    
    AppLocalizations.of(context).translate("genre_musical"),    
    AppLocalizations.of(context).translate("genre_romance"),    
    AppLocalizations.of(context).translate("genre_scifi"),      
    AppLocalizations.of(context).translate("genre_thriller"),   
    AppLocalizations.of(context).translate("genre_war"),        
    AppLocalizations.of(context).translate("genre_western"),    
  ];

  List<String> listGenresId = [
    ConstGenres.action.toString(),
    ConstGenres.adventure.toString(),
    ConstGenres.animation.toString(),
    ConstGenres.comedy.toString(),
    ConstGenres.crime.toString(),
    ConstGenres.documentary.toString(),
    ConstGenres.drama.toString(),
    ConstGenres.family.toString(),
    ConstGenres.fantasy.toString(),
    ConstGenres.history.toString(),
    ConstGenres.horror.toString(),
    ConstGenres.mistery.toString(),
    ConstGenres.music.toString(),
    ConstGenres.romance.toString(),
    ConstGenres.sciFi.toString(),
    ConstGenres.thriller.toString(),
    ConstGenres.war.toString(),
    ConstGenres.western.toString()
  ];

 List<Genres> listGenres = new List<Genres>();


 for (var i = 0; i < listGenresId.length; i++) {
   final Genres genre = new Genres(
      id: listGenresId[i],
      label: listGenresLabel[i],
      isKeyword: false,
      type: 'movies'
    );
    
    List<Genres> listNewGenres = new List<Genres>();

    listNewGenres.add(genre);

    listGenres.addAll(listNewGenres);
 }


 return listGenres;

}


List<Genres> getListGenresSeries(BuildContext context){
  
  List<String> listGenresLabel = [
    AppLocalizations.of(context).translate("genre_action_and_adventure"),       
    AppLocalizations.of(context).translate("genre_comedy"),     
    AppLocalizations.of(context).translate("genre_crime"),      
    AppLocalizations.of(context).translate("genre_documentary"),
    AppLocalizations.of(context).translate("genre_drama"),      
    AppLocalizations.of(context).translate("genre_scifi_fantasy"),    
    AppLocalizations.of(context).translate("genre_history"),    
    AppLocalizations.of(context).translate("genre_horror"),     
    AppLocalizations.of(context).translate("genre_mistery"),    
    AppLocalizations.of(context).translate("genre_musical"),    
    AppLocalizations.of(context).translate("genre_romance"),          
    AppLocalizations.of(context).translate("genre_thriller"),   
    AppLocalizations.of(context).translate("genre_war_politics"),        
    AppLocalizations.of(context).translate("genre_western"),    
  ];

  List<String> listGenresId = [
    ConstGenres.actionAndAveture.toString(),
    ConstGenres.comedy.toString(),
    ConstGenres.crime.toString(),
    ConstGenres.documentary.toString(),
    ConstGenres.drama.toString(),
    ConstGenres.sciFiAndFantasy.toString(),
    ConstGenres.history.toString(),
    ConstGenres.horror.toString(),
    ConstGenres.mistery.toString(),
    ConstGenres.music.toString(),
    ConstGenres.romance.toString(),
    ConstGenres.thriller.toString(),
    ConstGenres.warAndPolitics.toString(),
    ConstGenres.western.toString()
  ];

 List<Genres> listGenres = new List<Genres>();

 for (var i = 0; i < listGenresId.length; i++) {
   final Genres genre = new Genres(
      id: listGenresId[i],
      label: listGenresLabel[i],
      isKeyword: false,
      type: 'tv'
    );
    
    List<Genres> listNewGenres = new List<Genres>();

    listNewGenres.add(genre);

    listGenres.addAll(listNewGenres);
 }

 return listGenres;

}

List<Genres> getListGenresAnimes(BuildContext context){
  
  List<String> listGenresLabel = [
    AppLocalizations.of(context).translate("genre_action_and_adventure"),       
    AppLocalizations.of(context).translate("genre_comedy"),     
    AppLocalizations.of(context).translate("genre_crime"),      
    AppLocalizations.of(context).translate("genre_drama"),      
    AppLocalizations.of(context).translate("genre_scifi_fantasy"),    
    AppLocalizations.of(context).translate("genre_history"),    
    AppLocalizations.of(context).translate("genre_horror"),     
    AppLocalizations.of(context).translate("genre_mistery"),        
    AppLocalizations.of(context).translate("genre_romance"),             
    AppLocalizations.of(context).translate("genre_war_politics"),        
  ];

  List<String> listGenresId = [
    ConstGenres.actionAndAveture.toString(),
    ConstGenres.comedy.toString(),
    ConstGenres.crime.toString(),
    ConstGenres.drama.toString(),
    ConstGenres.sciFiAndFantasy.toString(),
    ConstGenres.history.toString(),
    ConstGenres.horror.toString(),
    ConstGenres.mistery.toString(),
    ConstGenres.romance.toString(),
    ConstGenres.warAndPolitics.toString(),
  ];

  List<String> listKeyLabel = [
    "Shonen",
    "Shojo",
    "Seinen",
    "Spokon",
    "Mecha",
    "Slice of Life"
  ];

  List<String> listKeyId = [
    "207826",
    "206437",
    "195668",
    "6075",
    "10046",
    "9914"
  ];
 List<Genres> listAllGenres = new List<Genres>(); 

 List<Genres> listGenres = new List<Genres>(); 
 List<Genres> listKeys = new List<Genres>();

 for (var i = 0; i < listGenresId.length; i++) {
   final Genres genre = new Genres(
      id: listGenresId[i],
      label: listGenresLabel[i],
      isKeyword: false,
      type: 'animes'
    );
    
    List<Genres> listNewGenres = new List<Genres>();

    listNewGenres.add(genre);

    listGenres.addAll(listNewGenres);
 }

 for (var i = 0; i < listKeyId.length; i++) {
   final Genres genre = new Genres(
      id: listKeyId[i],
      label: listKeyLabel[i],
      isKeyword: true,
      type: 'animes'
    );
    
    List<Genres> listNewKeys = new List<Genres>();

    listNewKeys.add(genre);

    listKeys.addAll(listNewKeys);
 }

 listAllGenres = listKeys + listGenres;

 return listAllGenres;

}



class Genres {

  final String label;
  final String id;
  final bool isKeyword;
  final String type;

  const Genres({this.label, this.id, this.isKeyword, this.type});

}