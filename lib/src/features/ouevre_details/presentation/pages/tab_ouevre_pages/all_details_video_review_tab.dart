import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_video_youtube/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_yt_item_widget.dart';
import 'package:bunkalist/src/premium_features/get_premium_app/presentation/widgets/feature_is_premium_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDetailsVideoReviewTab extends StatefulWidget {
  
  final String title;
  const AllDetailsVideoReviewTab({@required this.title});

  @override
  _AllDetailsVideoReviewTabState createState() => _AllDetailsVideoReviewTabState();
}

class _AllDetailsVideoReviewTabState extends State<AllDetailsVideoReviewTab> {




  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<VideoYoutubeBloc>(context)
    ..add(GetReviewsVideos(widget.title));
    
  } 

  Preferences prefs = Preferences(); 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<VideoYoutubeBloc, VideoYoutubeState>(
        builder: (context, state) {
          
          if(state is Empty){

            return LoadingCustomWidget();

          }else if(state is Loading){
            
            return LoadingCustomWidget();

          }else if(state is Loaded){

            if(state.videos.isEmpty || state.videos.length <= 0){
              
              return EmptyIconWidget();

            }else{
              return Container(
                child: Column(
                   mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/4818973727',),
                    //MaxNativeBannerAds(adPlacementID: "177059330328908_179583233409851",),
                    (!prefs.isNotAds)
                    ? FeaturePremiumWidget()
                    : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(5.0),
                        itemCount: state.videos.length,
                        itemBuilder: (context, i ) => AllDetailsYoutubeVideosItemWidget(video: state.videos[i]),
                      ),
                    ),
                  ],
                ),
              );
            }
            
          }else if(state is Error){
            
            return EmptyIconWidget();

          }

          return EmptyIconWidget();

        },
      ),
    );
  }
}