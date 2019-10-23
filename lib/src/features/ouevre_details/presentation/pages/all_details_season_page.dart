import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:flutter/material.dart';

class AllDetailsSeasonPage extends StatelessWidget {

  final int data;

  const AllDetailsSeasonPage({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarSeason(),
      body: _listEpisodeSeason(),
    );
  }

  Widget _appBarSeason() {
    return AppBar(
      leading: AppBarButtonBack(),
      title: Text('Season 1'),
    );
  }

  Widget _listEpisodeSeason() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, i) => _episodeItem(),
    );

  }

  Widget _episodeItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      child: Container(
        child: Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: _stackInfoEpisode(),
        ),
      ),
    );
  }

  Widget _stackInfoEpisode() {
    return Stack(
      children: <Widget>[
        _itemImageEpisode(),
        _columnEpisodeTextInfo()
      ],
    );
  }

  Widget _itemImageEpisode() {
    return Container(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage('https://image.tmdb.org/t/p/original/122cDgrjc5lFqUZ7cYi8vUVrcrn.jpg'),
          ),
      ),
    );
  }

  Widget _columnEpisodeTextInfo() {
    return Container(
      child: Column(
        children: <Widget>[
          _titleEpisodeItem(),
          _resumeEpisodeItem(),
          _rowRateAndDateEpisodeItem(),
        ]
      ),
    );
  }


  // Widget _rowInfoEpisode() {
  //   return IntrinsicHeight(
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         _itemImageEpisode(),
  //         _columnEpisodeTextInfo()
  //       ],
  //     ),
  //   );
  // }

  // Widget _itemImageEpisode() {
  //   return Expanded(
  //     flex: 1,
  //     child: Container(
  //       child: ClipRRect(
  //           borderRadius: BorderRadius.circular(10.0),
  //           child: Image(
  //             fit: BoxFit.cover,
  //             image: NetworkImage('https://image.tmdb.org/t/p/original/122cDgrjc5lFqUZ7cYi8vUVrcrn.jpg'),
  //           ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _columnEpisodeTextInfo() {
  //   return Expanded(
  //     flex: 2,
  //     child: Container(
  //       child: Column(
  //         children: <Widget>[
  //           _titleEpisodeItem(),
  //           _resumeEpisodeItem(),
  //           _rowRateAndDateEpisodeItem(),
            
  //         ]
  //       ),
  //     ),
  //   );
  // }

  Widget _titleEpisodeItem() {
    //! cambiar por un row para agregar la nota y la fecha de salida
    return Padding(
        padding: EdgeInsets.all(1.0),
        child: Text(
          '1. Currahee',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            shadows: [
              Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
            ]
          ),
        ),
    );
  }

  Widget _resumeEpisodeItem() {
    return Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            'Easy Company is introduced to Captain Sobel, who has the group undergo hard and unfair training. As a result, Sobel comes into conflict with his men, including Richard Winters, his executive officer. The company is shipped to England to prepare for D-Day.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
               shadows: [
              Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
            ]
            ),
            textAlign: TextAlign.justify,
          ),
    );
  }

  Widget _rowRateAndDateEpisodeItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.stars, color: Colors.deepOrange, size: 25.0,),
          SizedBox(width: 4.0,),
          Text('8.2', 
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 16.0, 
            fontWeight: FontWeight.w700,
            shadows: [
              Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
            ]
            ),
          ),
          Spacer(),
          Icon(Icons.today, color: Colors.grey[500], size: 25.0,),
          SizedBox(width: 4.0,),
          Text('21/09/2001',
           style: TextStyle( 
             fontSize: 14.0, 
             fontWeight: FontWeight.w500,
             color: Colors.white,
              shadows: [
              Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
              ]
             ),
             )
        ],
      ),
    );
  }

  
}