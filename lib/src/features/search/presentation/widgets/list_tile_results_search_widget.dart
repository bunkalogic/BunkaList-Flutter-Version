import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:flutter/material.dart';



class ListTileResultsSearchWidget extends StatefulWidget {
  
  final List<Result> results;

  ListTileResultsSearchWidget({@required this.results});

  @override
  _ListTileResultsSearchWidgetState createState() => _ListTileResultsSearchWidgetState();
}

class _ListTileResultsSearchWidgetState extends State<ListTileResultsSearchWidget> {
  @override
  Widget build(BuildContext context) {
    if(widget.results != null){
      
      return Container(
              child: ListView.builder(
                itemCount: widget.results.length,
                itemBuilder: (context , i) => _itemResultsListTile(widget.results[i])
              ),
            );
    }else{
      return Center(
            child: Container(
              child: Text('No Results Found. '),
            ),
          );
    }
  }


  Widget _itemResultsListTile(Result result){
    final title = (result.title != null) ? result.title : result.name;

    final String date = (result.releaseDate == null) ? result.firstAirDate : result.releaseDate;

    return ListTile(
      leading:  _itemResultPoster(result),
      title: Text(title, 
        style: TextStyle(
          fontSize: 18.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600
        ),
      ),
      subtitle:Text(date, 
        style: TextStyle(
          fontSize: 16.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(result.id, result.mediaType, title));
      }, 
    );
  }

  Widget _itemResultPoster(Result result) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ result.posterPath }');
    
    final _poster = Container(
      width: 50.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage(
          image: (result.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.contain,
        ),
      ),
    );

    return _poster;
  }
}