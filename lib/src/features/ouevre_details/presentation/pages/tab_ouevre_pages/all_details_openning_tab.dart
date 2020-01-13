import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_video_youtube/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_yt_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDetailsOpenningTab extends StatefulWidget {
  final String title;
  const AllDetailsOpenningTab({@required this.title});

  @override
  _AllDetailsOpenningTabState createState() => _AllDetailsOpenningTabState();
}

class _AllDetailsOpenningTabState extends State<AllDetailsOpenningTab> {

  final loadingPage = Center(
      child: CircularProgressIndicator(),
    ) ;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<VideoYoutubeBloc>(context)
    ..add(GetOpenningVideos(widget.title));
    
  }  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<VideoYoutubeBloc, VideoYoutubeState>(
        builder: (context, state) {
          
          if(state is Empty){

            return loadingPage;

          }else if(state is Loading){
            
            return loadingPage;

          }else if(state is Loaded){

            if(state.videos.isEmpty || state.videos.length <= 0){
              return Center(
                child: Text('no openning available'),
              );
            }else{
              return ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: state.videos.length,
                itemBuilder: (context, i ) => AllDetailsYoutubeVideosItemWidget(video: state.videos[i]),
              );
            }
            
          }else if(state is Error){
            
            return Center(
              child: Text(state.message),
            );

          }

          return Center(
              child: Text('something Error'),
            );

        },
      ),
    );
  }
}