import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
      height: MediaQuery.of(context).size.height / 3.8,
      child: CarouselSlider(
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: Duration(seconds: 10),
        items: <Widget>[
          _itemMoreTops(context, Color(0xFFE90F9E) , Color(0xFFF50057), Color(0xFFDE4708), moreMoviesLabel, 'movies'),
          _itemMoreTops(context, Color(0xFFA7FAAC) , Color(0xFF64FFDA), Color(0xFF00FFFF),  moreSeriesLabel,'tv'),
          _itemMoreTops(context, Color(0xFF49A9FF) , Color(0xFF2979FF), Color(0xFFB456D8),  moreAnimesLabel, 'animes'),
        ],
      ),
    );
  }

  Widget _itemMoreTops(BuildContext context ,Color color1, Color color2, Color color3, String title, String argsText){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/TopList', arguments: argsText);
      },
      child: Card(
        elevation: 15.0,
        margin: EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 20.0
        ),
        color: Colors.transparent,
        child: Container(
          child: _rowTextAndIcon(title),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                color1,
                color2,
                color3,
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
            fontStyle: FontStyle.italic,
            shadows: [
              Shadow(
                color: Colors.black87,
                blurRadius: 1.5,
              )
            ]
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