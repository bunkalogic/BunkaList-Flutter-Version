import 'package:bunkalist/src/core/reusable_widgets/chips_genres_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_list_genres.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/keywords_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BuildKeywordsWidget extends StatefulWidget {
  
  final int id;
  final String type;
  
  BuildKeywordsWidget({@required this.id, @required this.type});

  @override
  _BuildKeywordsWidgetState createState() => _BuildKeywordsWidgetState();
}

class _BuildKeywordsWidgetState extends State<BuildKeywordsWidget> with AutomaticKeepAliveClientMixin {
  
  
  @override
  void initState() {
    BlocProvider.of<OuevreDetailsBloc>(context)
    ..add(GetMoreDetailsOuevreKeywords(widget.id, widget.type));
    super.initState();
  } 

  
  @override
  Widget build(BuildContext context) {

    super.build(context);

    return BlocBuilder<OuevreDetailsBloc, OuevreDetailsState>(
     builder: (context, state){

      if(state is EmptyDetails){

          return SizedBox.shrink();

      }else if(state is LoadingDetails){
          
          return LoadingCustomWidget();

      }else if(state is LoadedKeywords){
        
        return Padding(
          padding: const EdgeInsets.only(left: 25, top: 10, bottom: 70.0),
          child: ChipsKeywordsWidget(keywords: _getKeywordsConversion(state.keywords.results),),
        );

      }else if(state is ErrorDetails){
          
          return Center(
            child: Text(state.message),
          );

        }

        return Center(
            child: Text('something Error'),
          );

     }
   );
  }


  List<Genres> _getKeywordsConversion(List<Result> results){
    
    List<Genres> keywords = [];

    results.forEach((item) { 

      Genres keyword = new Genres(
        id: item.id.toString(),
        isKeyword: true,
        label: item.name,
        type: widget.type == 'anime' 
          ? 'animes' : 
          widget.type == 'movie' 
          ? 'movies'
          : 'tv' 
      );
    
      keywords.add(keyword);
    
    });


    return keywords;
  }

  @override
  bool get wantKeepAlive => true;


}