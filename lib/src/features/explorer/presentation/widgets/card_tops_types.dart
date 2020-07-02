import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class CardTypesMoreTopsWidget extends StatelessWidget {
  

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
          _itemMoreTops(context, moreMoviesLabel, 'movies', 'https://image.tmdb.org/t/p/w1280/s3TBrRGB1iav7gFOCNx3H31MoES.jpg' ),
          _itemMoreTops(context, moreSeriesLabel,'tv', 'https://image.tmdb.org/t/p/w1280/ytQrbnfvblnbNRGoHAKsSrAo3B0.jpg' ),
          _itemMoreTops(context, moreAnimesLabel, 'animes', 'https://image.tmdb.org/t/p/w1280/vykRJ81Wqn9mGWAGUWVB2kOlTST.jpg' ),
        ],
      ),
    );
  }

  Widget _itemMoreTops(BuildContext context , String title, String argsText, String url){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/TopList', arguments: argsText);
      },
      child: Card(
        elevation: 5.0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20.0
        ),
        child: Stack(
          children: [
            _imageBackground(url),
            _shadowsBackground(),
            _rowTextAndIcon(title),
          ],
        ),

      ),
    );
  }

  Widget _rowTextAndIcon(String title) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.0,
              shadows: [
            Shadow(
              color: Colors.greenAccent[400],
              blurRadius: 1.0,
              offset: Offset(0.3, 0.3),
            ),
            Shadow(
              color: Colors.blueAccent[400],
              blurRadius: 1.0,
              offset: Offset(-0.3, 0.3),
            ),
            Shadow(
              color: Colors.redAccent[400],
              blurRadius: 1.0,
              offset: Offset(0.3, -0.3),
            ),
          ]
            ),
          ),
          Icon(
            Icons.arrow_forward,
            color: Colors.white
          ),
        ],
      ),
    );
  }

  Widget _shadowsBackground() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.black45,
      ),
    );
  }

  Widget _imageBackground(String url) {
    final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage(url);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: FadeInImage(
        image: poster,//? Image Poster Item,
        placeholder: placeholder, //? PlaceHolder Item,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    ); 
  }

}