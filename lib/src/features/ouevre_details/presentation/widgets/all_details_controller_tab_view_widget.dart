import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_credits/credits_bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_recommendations/recommendations_bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_reviews/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_similar/similar_bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_video_youtube/videoyoutube_bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_casting_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_info_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_openning_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_recomendation_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_review_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_season_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_similar_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_trailers_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_video_review_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';



class AllDetailsTabViewControllerWidget extends StatefulWidget {
  
  final Key idTab;
  final int id;
  final String type;
  final String title;
  
  AllDetailsTabViewControllerWidget({@required this.idTab, @required this.id, @required this.type, @required this.title });

  

  _AllDetailsTabViewControllerWidgetState createState() => _AllDetailsTabViewControllerWidgetState();
}

class _AllDetailsTabViewControllerWidgetState extends State<AllDetailsTabViewControllerWidget> {

  


  @override
  Widget build(BuildContext context) {
    switch(widget.type){
      
      case 'movie': return _getDetailsMovieTabView(widget.idTab);
        break;

      case 'tv':  return _getDetailsSerieTabView(widget.idTab);
        break;

      case 'anime': return _getDetailsAnimeTabView(widget.idTab);
        break; 

        default: return _getDetailsMovieTabView(widget.idTab); 

    }
  }

  Widget _getDetailsMovieTabView(Key idTab){

      switch(idTab.toString()){

      case '[<0>]': {
         return new BlocProvider<OuevreDetailsBloc>(
          builder: (_) => serviceLocator<OuevreDetailsBloc>(),
          child: AllDetailsInfoTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<1>]': {
         return new BlocProvider<CreditsBloc>(
          builder: (_) => serviceLocator<CreditsBloc>(),
          child: AllDetailsCastingTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<2>]': {
         return new BlocProvider<VideoYoutubeBloc>(
          builder: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsTrailerTab(title: widget.title),
        );
         
        }

      case '[<3>]': {
         return new BlocProvider<ReviewsBloc>(
          builder: (_) => serviceLocator<ReviewsBloc>(),
          child: AllDetailsReviewTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<4>]': {
         return new BlocProvider<VideoYoutubeBloc>(
          builder: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsVideoReviewTab(title: widget.title,),
        );
         
        }

      case '[<5>]': {
         return new BlocProvider<SimilarBloc>(
          builder: (_) => serviceLocator<SimilarBloc>(),
          child: AllDetailsSimilarTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<6>]': {
         return new BlocProvider<RecommendationsBloc>(
          builder: (_) => serviceLocator<RecommendationsBloc>(),
          child: AllDetailsRecomendationTab(id: widget.id, type: widget.type,),
        );
         
        }

      default: return Center(child: Text('Error tab'),);
    }

  }

  Widget _getDetailsSerieTabView(Key idTab){

      switch(idTab.toString()){

      case '[<0>]': {
         return new BlocProvider<OuevreDetailsBloc>(
          builder: (_) => serviceLocator<OuevreDetailsBloc>(),
          child: AllDetailsInfoTab(id: widget.id, type: widget.type,),
        );
         
        }
      case '[<1>]':  {
         return new BlocProvider<OuevreDetailsBloc>(
          builder: (_) => serviceLocator<OuevreDetailsBloc>(),
          child: AllDetailsSeasonTab(id: widget.id, type: widget.type,),
        );
         
        } 

      case '[<2>]': {
         return new BlocProvider<VideoYoutubeBloc>(
          builder: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsVideoReviewTab(title: widget.title,),
        );
         
        }  

      case '[<3>]': {
         return new BlocProvider<CreditsBloc>(
          builder: (_) => serviceLocator<CreditsBloc>(),
          child: AllDetailsCastingTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<4>]': {
         return new BlocProvider<VideoYoutubeBloc>(
          builder: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsTrailerTab(title: widget.title,),
        );
         
        }

      case '[<5>]': {
         return new BlocProvider<ReviewsBloc>(
          builder: (_) => serviceLocator<ReviewsBloc>(),
          child: AllDetailsReviewTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<6>]': {
         return new BlocProvider<SimilarBloc>(
          builder: (_) => serviceLocator<SimilarBloc>(),
          child: AllDetailsSimilarTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<7>]': {
         return new BlocProvider<RecommendationsBloc>(
          builder: (_) => serviceLocator<RecommendationsBloc>(),
          child: AllDetailsRecomendationTab(id: widget.id, type: widget.type,),
        );
         
        }

      default: return Center(child: Text('Error tab'),);
    }

  }

  Widget _getDetailsAnimeTabView(Key idTab){

      switch(idTab.toString()){

      case '[<0>]': {
         return new BlocProvider<OuevreDetailsBloc>(
          builder: (_) => serviceLocator<OuevreDetailsBloc>(),
          child: AllDetailsInfoTab(id: widget.id, type: widget.type,),
        );
         
        }
      case '[<1>]':  {
         return new BlocProvider<OuevreDetailsBloc>(
          builder: (_) => serviceLocator<OuevreDetailsBloc>(),
          child: AllDetailsSeasonTab(id: widget.id, type: widget.type,),
        );
         
        } 

      case '[<2>]': {
         return new BlocProvider<VideoYoutubeBloc>(
          builder: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsVideoReviewTab(title: widget.title,),
        );
         
        }   

      case '[<3>]': {
         return new BlocProvider<CreditsBloc>(
          builder: (_) => serviceLocator<CreditsBloc>(),
          child: AllDetailsCastingTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<4>]': {
         return new BlocProvider<VideoYoutubeBloc>(
          builder: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsTrailerTab(title: widget.title,),
        );
         
        }

      case '[<5>]': {
         return new BlocProvider<ReviewsBloc>(
          builder: (_) => serviceLocator<ReviewsBloc>(),
          child: AllDetailsReviewTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<6>]': {
         return new BlocProvider<SimilarBloc>(
          builder: (_) => serviceLocator<SimilarBloc>(),
          child: AllDetailsSimilarTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<7>]':  {
         return new BlocProvider<RecommendationsBloc>(
          builder: (_) => serviceLocator<RecommendationsBloc>(),
          child: AllDetailsRecomendationTab(id: widget.id, type: widget.type,),
        );
         
        }
      
      // case '[<8>]': {
      //    return new BlocProvider<VideoYoutubeBloc>(
      //     builder: (_) => serviceLocator<VideoYoutubeBloc>(),
      //     child: AllDetailsOpenningTab(title: widget.title,),
      //   );
         
      //   } 

      default: return Center(child: Text('Error tab'),);
    }

  }
  
  
}