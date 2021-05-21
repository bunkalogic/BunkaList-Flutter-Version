import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
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

    Preferences prefs = Preferences();

    final ThemeData theme = Theme.of(context);

    assert(theme != null);

    return theme.copyWith(
      primaryColor: prefs.whatModeIs ? prefs.whatDarkIs ? Colors.grey[900] : Colors.blueGrey[900]  : Colors.grey[200],
      // buttonColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
      primaryIconTheme: IconThemeData(
        color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
        size: 40.0
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none
      )
    );
  }

 

  @override
  TextInputAction get textInputAction => TextInputAction.search;
  

  @override
  String get searchFieldLabel => 'Search Movies, TV Series & Anime';

  @override
  List<Widget> buildActions(BuildContext context) {
    Preferences prefs = Preferences();
    return [
      IconButton(
        icon: Icon(Icons.clear, color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],),
        onPressed: () => query = '',
      )
    ];
  }

  

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.keyboard_arrow_down_rounded, size: 28,),
      onPressed: () => close(context, null),
    );
  }
  

  @override
  Widget buildResults(BuildContext context) {
    
    //We pass the query to the event bloc
    if(query.isEmpty){
      searchBloc.add(SearchCleared());
    }else{
      searchBloc.add(SearchStarted(query));
    }
    

    return BlocBuilder(
      bloc: searchBloc,
      builder: (BuildContext context, SearchState state){

        if(state is SearchInitial){
          return SearchIconWidget();
        }

        if (state is SearchInProgress) {
          return Center(
            child: LoadingCustomWidget()
          );
        } else if (state is SearchSuccess) {
          
          return CardViewSearchResultsWidget(searchBloc);


        } else if (state is SearchFailure) {

          return SearchIconWidget();

        } else {
          
          throw StateError('Unknown state: $state');

        }
        

      },
    );

    

  }

  

  @override
  Widget buildSuggestions(BuildContext context) {

    //We pass the query to the event bloc
    if(query.isEmpty){
      searchBloc.add(SearchCleared());
    }else{
      searchBloc.add(SearchStarted(query));
    }

    return BlocBuilder(
      bloc: searchBloc,
      builder: (BuildContext context, SearchState state){
        
        if(state is SearchInitial){
          return SearchIconWidget();
        }

        if (state is SearchInProgress) {
          return Center(
            child: LoadingCustomWidget()
          );
        } else if (state is SearchSuccess) {

          return ListTileResultsSearchWidget(results: state.results);

        } else if (state is SearchFailure) {

          return SearchIconWidget();
          
        } else {
          
          throw StateError('Unknown state: $state');

        }        
      },
    );
  }

}