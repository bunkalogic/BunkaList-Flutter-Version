import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:snap/snap.dart';



class VideoPlayerWidget extends StatefulWidget {
  final String id;

  VideoPlayerWidget({@required this.id});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {


  GlobalKey bound = GlobalKey();
  GlobalKey view = GlobalKey(); 
  
  YoutubePlayerController _controller;

  final Preferences prefs = Preferences();  

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        controlsVisibleAtStart: true
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.transparent, 
      body: Align(
        key: bound,
        alignment: const Alignment(-1.0, -1.0),
        child: SnapController(
          translatedBox(), 
          false, 
          view,
          bound,
          Offset(50.0 / MediaQuery.of(context).size.width, 50.0 / MediaQuery.of(context).size.height),
          Offset(1.0, 1.0) - Offset(50.0 / MediaQuery.of(context).size.width, 50.0 / MediaQuery.of(context).size.height),
          const Offset(0.75, 0.75),
          const Offset(0.75, 0.75),
          snapTargets: [
            SnapTarget(Pivot.topLeft, Offset(50.0 / MediaQuery.of(context).size.width, 50.0 / MediaQuery.of(context).size.height)),
            SnapTarget(Pivot.topRight, Offset(1.0 - 50.0 / MediaQuery.of(context).size.width, 50.0 / MediaQuery.of(context).size.height)),
            SnapTarget(Pivot.bottomLeft, Offset(50.0 / MediaQuery.of(context).size.width, 1.0 - 50.0 / MediaQuery.of(context).size.height)),
            SnapTarget(Pivot.bottomRight, Offset(1.0, 1.0) - Offset(50.0 / MediaQuery.of(context).size.width, 50.0 / MediaQuery.of(context).size.height)),
            const SnapTarget(Pivot.center, Pivot.center),
          ],
          
          //onMove            : _onMove,
          //onDragStart       : _onDragStart,
          //onDragUpdate      : _onDragUpdate,
          //onDragEnd         : _onDragEnd,
          //onFlick           : _onFlick
        ),
      ),
      floatingActionButton: _fabcenter(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  Widget _youtubeVideoPlayer(){
    return Container(
      padding: EdgeInsets.all(2.0),
      child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          actionsPadding: EdgeInsets.all(2.0),
          topActions: <Widget>[
            FullScreenButton(controller: _controller,)
          ],
          bottomActions: <Widget>[
            CurrentPosition(controller: _controller),
            ProgressBar(isExpanded: true,),
          ],
          onReady: () {
            print('Player is ready.');
          },
        ),
    );
  }

   Widget translatedBox() {
    return Transform.translate(
      offset: const Offset(50, 50),
      child: Container(
        key: view,
        width: 300,
        height: 200,
        color: Colors.transparent,
        child: _youtubeVideoPlayer()
      ),
    );
  }

  _fabcenter() {
    return FloatingActionButton(
      onPressed: () => Navigator.pop(context),
      elevation: 20.0,
      child: Icon(Icons.close),
      backgroundColor: Colors.purpleAccent[700],
    );
  }

}