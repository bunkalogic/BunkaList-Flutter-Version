import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class CardTypesMoreTopsWidget extends StatelessWidget {
  

  final _pageController = new PageController(
    initialPage: 0,
    viewportFraction: 1.0,
  );

  final List<String> imagesMovies = [
    'https://image.tmdb.org/t/p/w1280/s3TBrRGB1iav7gFOCNx3H31MoES.jpg',
    'https://image.tmdb.org/t/p/w1280/lXhgCODAbBXL5buk9yEmTpOoOgR.jpg',
    'https://image.tmdb.org/t/p/w1280/o0pWmY8Rfdiy70xBFHc5ADkmm5w.jpg',
    'https://image.tmdb.org/t/p/w1280/xJHokMbljvjADYdit5fK5VQsXEG.jpg',
    'https://image.tmdb.org/t/p/w1280/ApiBzeaa95TNYliSbQ8pJv4Fje7.jpg',
    'https://image.tmdb.org/t/p/w1280/mMtUybQ6hL24FXo0F3Z4j2KG7kZ.jpg',
  ];

  final List<String> imagesSeries = [
    'https://image.tmdb.org/t/p/w1280/ytQrbnfvblnbNRGoHAKsSrAo3B0.jpg',
    'https://image.tmdb.org/t/p/w1280/tsRy63Mu5cu8etL1X7ZLyf7UP1M.jpg',
    'https://image.tmdb.org/t/p/w1280/sWLGOiFGwjpxEF2f9Kp3srg1X0y.jpg',
    'https://image.tmdb.org/t/p/w1280/oggnxmvofLtGQvXsO9bAFyCj3p6.jpg',
    'https://image.tmdb.org/t/p/w1280/n6teSMdqSBslpD4JGc5qs7gwmfs.jpg',
    'https://image.tmdb.org/t/p/w1280/yGNnjoIGOdQy3douq60tULY8teK.jpg',
  ];

  final List<String> imagesAnimes = [
    'https://image.tmdb.org/t/p/w1280/vykRJ81Wqn9mGWAGUWVB2kOlTST.jpg',
    'https://image.tmdb.org/t/p/w1280/A6tMQAo6t6eRFCPhsrShmxZLqFB.jpg',
    'https://image.tmdb.org/t/p/w1280/ly0tvRfOp936Zmr6vepusFeo7lp.jpg',
    'https://image.tmdb.org/t/p/w1280/9IAfHmcPcQjKEzlAwnY777iItbi.jpg',
    'https://image.tmdb.org/t/p/w1280/pL2VkIcoHnyX5oLd3IIaANkzB01.jpg',
    'https://image.tmdb.org/t/p/w1280/fGXhmKyqRmx6NN3gQHeWNmiEryl.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final moreMoviesLabel = AppLocalizations.of(context).translate("more_tops_movies");
    final moreSeriesLabel = AppLocalizations.of(context).translate("more_tops_series");
    final moreAnimesLabel = AppLocalizations.of(context).translate("more_tops_animes");

    imagesMovies.shuffle();
    imagesSeries.shuffle();
    imagesAnimes.shuffle();

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
          _itemMoreTops(context, moreMoviesLabel, 'movies', imagesMovies.first ),
          _itemMoreTops(context, moreSeriesLabel,'tv', imagesSeries.first ),
          _itemMoreTops(context, moreAnimesLabel, 'animes', imagesAnimes.first ),
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