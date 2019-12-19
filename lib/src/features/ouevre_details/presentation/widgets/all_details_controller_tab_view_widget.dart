import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_reviews/bloc.dart';
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
  
  
  AllDetailsTabViewControllerWidget({@required this.idTab, @required this.id, @required this.type});

  

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

      case '[<1>]': return AllDetailsCastingTab();

      case '[<2>]': return AllDetailsTrailerTab();

      case '[<3>]': {
         return new BlocProvider<ReviewsBloc>(
          builder: (_) => serviceLocator<ReviewsBloc>(),
          child: AllDetailsReviewTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<4>]': return AllDetailsVideoReviewTab();

      case '[<5>]': return AllDetailsSimilarTab();

      case '[<6>]': return AllDetailsRecomendationTab(); 

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

      case '[<2>]': return AllDetailsVideoReviewTab();   

      case '[<3>]': return AllDetailsCastingTab();

      case '[<4>]': return AllDetailsTrailerTab();

      case '[<5>]': {
         return new BlocProvider<ReviewsBloc>(
          builder: (_) => serviceLocator<ReviewsBloc>(),
          child: AllDetailsReviewTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<6>]': return AllDetailsSimilarTab();

      case '[<7>]': return AllDetailsRecomendationTab(); 

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

      case '[<2>]': return AllDetailsVideoReviewTab();   

      case '[<3>]': return AllDetailsCastingTab();

      case '[<4>]': return AllDetailsTrailerTab();

      case '[<5>]': {
         return new BlocProvider<ReviewsBloc>(
          builder: (_) => serviceLocator<ReviewsBloc>(),
          child: AllDetailsReviewTab(id: widget.id, type: widget.type,),
        );
         
        }

      case '[<6>]': return AllDetailsSimilarTab();

      case '[<7>]': return AllDetailsRecomendationTab(); 
      
      case '[<8>]': return AllDetailsOpenningTab(); 

      default: return Center(child: Text('Error tab'),);
    }

  }
  
  
}