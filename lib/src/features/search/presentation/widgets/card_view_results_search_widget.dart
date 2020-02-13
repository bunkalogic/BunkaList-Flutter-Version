import 'package:bunkalist/src/core/reusable_widgets/chips_genres_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/core/utils/get_search_filter_by_type.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardViewSearchResultsWidget extends StatefulWidget {
  
  final List<Result> results;

  CardViewSearchResultsWidget({@required this.results});

  @override
  _CardViewSearchResultsWidgetState createState() => _CardViewSearchResultsWidgetState();
}

class _CardViewSearchResultsWidgetState extends State<CardViewSearchResultsWidget> {
  

  final loadingPage = Center(
      child: CircularProgressIndicator(),
    ) ;
  
  
  @override
  Widget build(BuildContext context) {

    if(widget.results != null){
      
      return Container(
              child: ListView.builder(
                itemCount: widget.results.length,
                itemBuilder: (context , i) => _buildCardItem(widget.results[i]),
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
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(child: _rowInfoItem(result)),
          //SizedBox(height: 10.0,),
          //_chipGenresItem(result),
          Expanded(child: ChipsGenresWidget(genres: result.genreIds.cast<int>(),), flex: 1,),
          //SizedBox(height: 35.0,),
          Expanded(child: _rowButtons(),flex: 1,),
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
        Expanded(child: _titleItem(result), flex: 3, ),
        Spacer(),
        Expanded(child: _yearOfItem(result), flex: 1,),
        Spacer(),
        Expanded(child: _rateItem(result), flex: 2, )
        ],
      ),
    );
  }

  Widget _posterItem(Result result) {

     final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/original${ result.posterPath }');

    //! Agregar el Hero
    final _poster = Container(
      width: 110.0,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: (result.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
      ),
    );

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(result.id, result.mediaType, result.title));
          },
          child: _poster 
      ),
    );
  }

  Widget _titleItem(Result result) {

    final String title = (result.title == null) ? result.name : result.title;
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
          title, 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic,
            ),
            overflow: TextOverflow.ellipsis,
          ),
    );
  }

  Widget _yearOfItem(Result result) {

    final String date = (result.releaseDate == null) ? result.firstAirDate : result.releaseDate;

    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
          (date.isEmpty)  ?'No date'  : DateTime.parse(date).year.toString(), 
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),   
        ),
    );
  }

  Widget _rateItem(Result result) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
      child: Row(
        children: <Widget>[
          Text(result.voteAverage.toString(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Colors.orange[800]),),
          Icon(Icons.star, size: 20, color: Colors.orange[800], ) 
        ],
      ),
    );
  }

  Widget _rowButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
         _buttonActions(Icons.check_circle, Colors.green), 
         _buttonActions(Icons.play_circle_filled, Colors.blue),
         _buttonActions(Icons.pause_circle_filled, Colors.orange),
         _buttonActions(Icons.remove_circle, Colors.red),
         _buttonActions(Icons.add_circle, Colors.purple),
        ],
      ),
    );
  }

  Widget _buttonActions(IconData icon, Color color){
    return IconButton(
      icon: Icon(
        icon, 
        size: 25.0, 
        color: color,
        ),
        onPressed: () {},
    );
  }
}