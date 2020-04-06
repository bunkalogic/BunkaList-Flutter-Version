import 'package:bunkalist/src/features/ouevre_details/domain/entities/youtube_video_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AllDetailsYoutubeVideosItemWidget extends StatelessWidget {

  final VideoYoutubeEntity video;

  const AllDetailsYoutubeVideosItemWidget({@required this.video});

  @override
  Widget build(BuildContext context) {
    return _columnVideoInfo(context);
  }

  Widget _columnVideoInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          _itemVideoImage(context),
          _itemVideoTitle(),
          _itemVideoChannelName(),
          SizedBox(height: 5.0,),
          _itemVideoURL()
          //_rowSubTitle()
        ],
      ),
    );
  }

  Widget _itemVideoImage(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: _stackImage(context),
    );
  }
  Widget _stackImage(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => VideoPlayerWidget( id: video.id, ),
        ));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _thumbnailsImage(),
          _iconPlay()
        ],
      ),
    );
  }

  Widget _thumbnailsImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image(
        fit: BoxFit.cover,
        
        image: NetworkImage(video.thumbnailUrl),
      ),
    );
  }

  Widget _iconPlay() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Center(
        child: Image(
        fit: BoxFit.cover,
        height: 50.0,  
        image: AssetImage('assets/icon-youtube.png'),
        
        ),
      ),
    );
  }

  Widget _itemVideoTitle() {
    return Container(
      child: Text(
        video.title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }

  Widget _itemVideoChannelName() {
    return Container(
      child: Text(
        video.channelTitle,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  Widget _itemVideoURL() {
    final url = 'https://www.youtube.com/watch?v=${video.id}';
    return GestureDetector(
      onTap: () => launch(url),
      child: Container(
        child: Text(
          url,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
            decoration: TextDecoration.underline
          ),
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