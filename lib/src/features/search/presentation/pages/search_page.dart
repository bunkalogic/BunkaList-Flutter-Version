import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:bunkalist/src/features/search/presentation/bloc/bloc.dart';
import 'package:bunkalist/src/features/search/presentation/widgets/card_view_results_search_widget.dart';
import 'package:bunkalist/src/features/search/presentation/widgets/list_tile_results_search_widget.dart';
import 'package:bunkalist/src/features/search/presentation/widgets/search_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiSearchWidget extends SearchDelegate<ResultsEntity>{

  final Bloc<SearchEvent, SearchState> searchBloc;

  MultiSearchWidget (this.searchBloc);


  

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);

    final ThemeData theme = Theme.of(context);

    assert(theme != null);

    return theme;
  }

 

  @override
  TextInputAction get textInputAction => TextInputAction.search;
  

  @override
  String get searchFieldLabel => 'Search Movies, TV Series & Anime';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.white,),
        onPressed: () => query = '',
      )
    ];
  }

  

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.chevron_left),
      onPressed: () => close(context, null),
    );
  }
  

  @override
  Widget buildResults(BuildContext context) {
    
    //We pass the query to the event bloc
    searchBloc.add(TextSearchChanged(text: query));

    return BlocBuilder(
      bloc: searchBloc,
      builder: (BuildContext context, SearchState state){

        
        
        if (state is EmptySearch && query.isEmpty) {

          return SearchIconWidget();

        } 
        
        if(state is LoadingSearch){

         return LoadingCustomWidget();

        }
        
        if(state is LoadedSearch && query.isNotEmpty){

        return CardViewSearchResultsWidget(results: state.results);

        }

        return SearchIconWidget();
        
        

      },
    );

    

  }

  

  @override
  Widget buildSuggestions(BuildContext context) {

   //We pass the query to the event bloc
    searchBloc.add(TextSearchChanged(text: query));

    return BlocBuilder(
      bloc: searchBloc,
      builder: (BuildContext context, SearchState state){
        
        if (state is EmptySearch && query.isEmpty) {

          return SearchIconWidget();

        } 
        
        if(state is LoadingSearch){

         return LoadingCustomWidget();

        }
        
        if(state is LoadedSearch && query.isNotEmpty){

        return ListTileResultsSearchWidget(results: state.results,); 

        }

        return SearchIconWidget();
        
         
        
        
      },
    );
  }

}