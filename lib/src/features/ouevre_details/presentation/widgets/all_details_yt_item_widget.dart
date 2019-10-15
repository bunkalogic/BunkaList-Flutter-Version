import 'package:flutter/material.dart';


class AllDetailsYoutubeVideosItemWidget extends StatelessWidget {
  const AllDetailsYoutubeVideosItemWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _columnVideoInfo();
  }

  Widget _columnVideoInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          _itemVideoImage(),
          _itemVideoTitle(),
          _rowSubTitle()
        ],
      ),
    );
  }

  Widget _itemVideoImage() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: _stackImage(),
    );
  }
  Widget _stackImage(){
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _thumbnailsImage(),
        _iconPlay()
      ],
    );
  }

  Widget _thumbnailsImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image(
        fit: BoxFit.cover,
        image: NetworkImage('https://image.tmdb.org/t/p/w533_and_h300_bestv2/8ApdRREQ82KDPAEH6BB15m4rpK3.jpg'),
      ),
    );
  }

  Widget _iconPlay() {
    return Align(
      child: Icon(
        Icons.play_arrow,
        size: 80.0,
        color: Colors.redAccent.withOpacity(0.7),
      ),
    );
  }

  Widget _itemVideoTitle() {
    return Container(
      child: Text(
        'Bands of Brothers 2001 Trailer',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }

  Widget _rowSubTitle() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.high_quality, size: 25.0, color: Colors.redAccent,),
          Text('720p', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700), ),
          SizedBox(width: 20.0,),
          Icon(Icons.timeline, size: 25.0, color: Colors.purpleAccent,),
          Text('344k views', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700), )
        ],
      ),
    );
  }

  

  
}