import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';


class CardMoreTopsWidget extends StatelessWidget {
  

  final _pageController = new PageController(
    initialPage: 0,
    viewportFraction: 1.0,
  );

  @override
  Widget build(BuildContext context) {
    final moreMoviesLabel = AppLocalizations.of(context).translate("more_tops_movies");
    final moreSeriesLabel = AppLocalizations.of(context).translate("more_tops_series");
    final moreAnimesLabel = AppLocalizations.of(context).translate("more_tops_animes");


    return Container(
      height: MediaQuery.of(context).size.height / 3.6,
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _itemMoreTops(context, Colors.pinkAccent , Colors.pinkAccent[400], Colors.redAccent[400], Colors.redAccent[700], moreMoviesLabel, 'movies'),
          _itemMoreTops(context, Colors.tealAccent , Colors.tealAccent[400], Colors.greenAccent[400], Colors.greenAccent[700], moreSeriesLabel,'tv'),
          _itemMoreTops(context, Colors.cyanAccent , Colors.cyanAccent[400], Colors.blueAccent[400], Colors.blueAccent[400], moreAnimesLabel, 'animes'),
        ],
      ),
    );
  }

  Widget _itemMoreTops(BuildContext context ,Color color1, Color color2, Color color3,Color color4, String title, String argsText){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/TopList', arguments: argsText);
      },
      child: Card(
        elevation: 15.0,
        margin: EdgeInsets.symmetric(
          horizontal: 50.0,
          vertical: 30.0
        ),
        color: Colors.transparent,
        child: Container(
          child: _rowTextAndIcon(title),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              colors: [
                color1,
                color2,
                color3,
                color4
              ]
            )    
          ) 
        ),

      ),
    );
  }

  Widget _rowTextAndIcon(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic
          ),
        ),
        Icon(
          Icons.arrow_forward,
          color: Colors.white
        ),
      ],
    );
  }

}