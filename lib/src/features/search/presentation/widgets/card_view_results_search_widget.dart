
import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/reusable_widgets/bottom_loader_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/chips_genres_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/circular_chart_rating.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:bunkalist/src/features/search/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class CardViewSearchResultsWidget extends StatefulWidget {
  
  //final List<Result> results;
final Bloc<SearchEvent, SearchState> searchBloc;

  CardViewSearchResultsWidget(
    this.searchBloc
    //{@required this.results}
    );

  @override
  _CardViewSearchResultsWidgetState createState() => _CardViewSearchResultsWidgetState();
}

class _CardViewSearchResultsWidgetState extends State<CardViewSearchResultsWidget> {
  
  ScrollController _scrollController;
  int currentPage = 1;
  int totalPages = 0;
  bool _loading = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }


  void _loadPage(int page) {

    SearchState state = widget.searchBloc.state;
    //Queue<SearchEvent> queue = BlocProvider.of<SearchQueueBloc>(context).state;

    if (state is SearchSuccess && state.canLoadMore) {
      // If already loading this page, don't put in queue.
      if (state is SearchPageLoadInProgress && state.page == page) {
        return;
        // If it's already in the queue, don't put in queue.
      }else{  
        widget.searchBloc.add(SearchPageRequested(page));
        
      }
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    SearchSuccess state = widget.searchBloc.state as SearchSuccess;
    List<Result> results = state.results;

    totalPages = state.numPages;    

    if(results.isNotEmpty){
      
      return Container(
              child: NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.hasReachedMax
                    ? results.length
                    : results.length + 1,
                  itemBuilder: (context , i) {
                    _loading = false;
                    
                    return (i >= results.length) 
                    ? BottomLoader()
                    : _buildCardItem(results[i]);
                  } 
                ),
              ),
            );
    }else{
      return Center(
            child: Container(
              child: Text(
                'No Results Found. ',
                style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800, 
              fontStyle: FontStyle.italic,
            ),
              ),
            ),
          );
    }
  }

  Widget _buildCardItem(Result result) {
    
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
       child: Container(
         child: _itemInfo(result),
         height: 160.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              colors: [
                Colors.grey[400].withOpacity(0.1),
                Colors.grey[500].withOpacity(0.1),
                Colors.grey[600].withOpacity(0.1),
              ]
            ) 
          ),
       ),
     ); 
  }

  Widget _itemInfo(Result result) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _posterItem(result),
        SizedBox(width: 6.0,),
        Expanded(child: _columnCenterItem(result))
      ],
    );

  }

  Widget _columnCenterItem(Result result){

    final type = 
    result.mediaType == 'movie' 
    ? 'movies' : 
    result.mediaType == 'anime' 
    ? 'animes' : "tv";

    return Container(
      child: Column(
        children: <Widget>[
          Expanded(child: _rowInfoItem(result)),
          //SizedBox(height: 10.0,),
          //_chipGenresItem(result),
          result.mediaType == 'person'
          ? _knownForDeparment(result)
          :Expanded(
            child: ChipsGenresWidget(
              genres: result.genreIds.cast<int>(),
              type: type,
              isWrap: false,
            ), 
          flex: 1,
          ),
          //SizedBox(height: 35.0,),
          Expanded(child: _rowButtons(result),flex: 1,),
        ],
      ),
    );
  }

  Widget _rowInfoItem(Result result){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Expanded(child: _titleItem(result), flex: 5, ),
        //Spacer(),
        Expanded(child: _yearOfItem(result), flex: 2,),
        //Spacer(),
        Expanded(child: _rateItem(result), flex: 3, )
        ],
      ),
    );
  }

  Widget _posterItem(Result result) {

     final placeholder = AssetImage('assets/poster_placeholder.png');
     final placeholderPerson = AssetImage('assets/photo-placeholder.png');  
     final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ result.posterPath }');
     final photoPerson = NetworkImage('https://image.tmdb.org/t/p/w185${result.profilePath}');

     final title = (result.title != null) ? result.title : result.name;

    //! Agregar el Hero
    final _poster = Container(
      width: 110.0,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: (result.posterPath == null && result.profilePath == null) 
          ? result.mediaType == 'person' 
            ? placeholderPerson
            : placeholder 
          : result.mediaType == 'person' 
            ? photoPerson  
            : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
      ),
    );

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      child: GestureDetector(
          onTap: (){

            if(result.mediaType == "person"){
              Navigator.pushNamed(context, '/AllDetailsPeople', arguments: getIdAndNameCast(result.id, result.name));
            }else{
              Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(result.id, result.mediaType, title));
            }  

            
          },
          child: _poster 
      ),
    );
  }

  Widget _titleItem(Result result) {

    final String title = (result.title == null) ? result.name : result.title;
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Text(
          result.mediaType == "person" ? result.name : title, 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic,
            ),
            overflow: TextOverflow.ellipsis,
          ),
    );
  }

  Widget _knownForDeparment(Result result){
    return Container(
      child: Center(
        child: Text(
          result.knownForDepartment,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500, 
              fontStyle: FontStyle.italic,
            ),
        ),
      ),
    );
  }

  Widget _yearOfItem(Result result) {
    if(result.mediaType == 'person') return Container();

    String date = (result.releaseDate == null) ? result.firstAirDate : result.releaseDate;

    date = (date == null) ? 'No date' : date;

    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Text(
          (date.isEmpty)  
          ? 'No date' 
          : (date == 'No date')
            ? 'No date'
            : DateTime.parse(date).year.toString(), 
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),   
        ),
    );
  }

  Widget _rateItem(Result result) {
    if(result.mediaType == 'person') return Container();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 1.5),
      child: MiniCircularChartRating(result.voteAverage),
    );
  }

  Widget _rowButtons(Result result) {
    if(result.mediaType == 'person') return Container();

    return BlocProvider<AddOuevreBloc>(
          create: (_) => serviceLocator<AddOuevreBloc>(),
          child: MultiButtonsAdded(ouevre: result, type: result.mediaType, objectType: ConstantsTypeObject.searchResult,),
        );
  }

  

  bool _handleScrollNotification(ScrollNotification notification){
     if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0){
        if(currentPage < totalPages){
          print('load new page');
          currentPage+=1;  
          _loadPage(currentPage);
          return _loading = true;
        } 
        print('dont load new page');  
    }
    return _loading = false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}