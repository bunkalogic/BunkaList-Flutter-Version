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



class AllDetailsTabViewControllerWidget extends StatefulWidget {
  AllDetailsTabViewControllerWidget({@required this.idStatus});

  final Key idStatus;

  _AllDetailsTabViewControllerWidgetState createState() => _AllDetailsTabViewControllerWidgetState();
}

class _AllDetailsTabViewControllerWidgetState extends State<AllDetailsTabViewControllerWidget> {

  


  @override
  Widget build(BuildContext context) {
    return _getDetailsTabView(widget.idStatus);
  }

  Widget _getDetailsTabView(Key idStatus){

    /**
     * TODO: refactorizar y implementar la comprobacion de que tipo
     *  es devoler las tabs que sean necesarias
     */


    switch(idStatus.toString()){

      case '[<0>]': return AllDetailsInfoTab();

      case '[<1>]': return AllDetailsCastingTab();

      case '[<2>]': return AllDetailsTrailerTab();

      case '[<3>]': return AllDetailsReviewTab();

      case '[<4>]': return AllDetailsVideoReviewTab();

      case '[<5>]': return AllDetailsSimilarTab();

      case '[<6>]': return AllDetailsRecomendationTab(); 

      case '[<7>]': return AllDetailsSeasonTab(); 

      case '[<8>]': return AllDetailsOpenningTab(); 

      default: return Center(child: Text('Error tab'),);
    }
  }
  
}