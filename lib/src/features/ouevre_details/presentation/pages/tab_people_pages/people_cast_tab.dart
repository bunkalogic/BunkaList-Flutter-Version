import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/format_date.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_credits_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_people/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleCastTab extends StatefulWidget {
 final int id;

 PeopleCastTab({@required this.id});

  @override
  _PeopleCastTabState createState() => _PeopleCastTabState();
}

class _PeopleCastTabState extends State<PeopleCastTab> {
  
  

       


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PeopleInfoBloc>(context)
    ..add(GetCreditsPeople(widget.id));
    
  }
  
  @override
  Widget build(BuildContext context) {

    return Container(
      child: BlocBuilder<PeopleInfoBloc, PeopleInfoState>(
        builder: (context, state) {
          
          if(state is Empty){

            return LoadingCustomWidget();

          }else if(state is Loading){
            
            return LoadingCustomWidget();

          }else if(state is LoadedCreditsPeople){

            final List<CastAndCrew> listCast = new List<CastAndCrew>.from(state.people.cast);

            return ListView.builder(
              itemCount: listCast.length,
              itemBuilder: (context , i) => _buildCardItem(listCast[i]),
            );

          }else if (state is Error){
             
             return Center(
              child: Text(state.message),
            );
          }
          return Center(
              child: Text('something Error'),
            );
        }
      )      
    ); 



    
  }

  Widget _buildCardItem(CastAndCrew cast) {
     final id = cast.id;
      final type = cast.mediaType;
      final String getTitle = (cast.mediaType == 'movie') ? cast.name : cast.title;

     return GestureDetector(
       onTap: (){
         Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(id, type, getTitle));
       },
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
         child: Container(
           child: _itemInfo(cast),
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
       ),
     ); 
  }

  Widget _itemInfo(CastAndCrew cast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _posterItem(cast),
        SizedBox(width: 6.0,),
        Expanded(child: _columnCenterItem(cast))
      ],
    );

  }

  Widget _columnCenterItem(CastAndCrew cast){
    return Container(
      child: Column(
        children: <Widget>[
          _rowInfoItem(cast),
          //SizedBox(height: 10.0,),
          _infoCharacter(cast),
          _infoEpisodeCount(cast),
          //SizedBox(height: 35.0,),
          _rowButtons(),
        ],
      ),
    );
  }

  Widget _rowInfoItem(CastAndCrew cast){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Expanded(child: _titleItem(cast), flex: 3, ),
        Spacer(),
        Expanded(child: _yearOfItem(cast), flex: 1,),
        Spacer(),
        Expanded(child: _rateItem(cast), flex: 2,)
        ],
      ),
    );
  }

  Widget _posterItem(CastAndCrew cast) {
    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/original${ cast.posterPath }');

    //! Agregar el Hero
    return Container(
      width: 110.0,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: (cast.posterPath == null) ? placeholder : poster ,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _titleItem(CastAndCrew cast) {

    final String getTitle = (cast.mediaType == 'movie') ? cast.title : cast.name;


    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
            getTitle, 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),
             overflow: TextOverflow.ellipsis,
          ),
    );
  }

  Widget _yearOfItem(CastAndCrew cast) {

    final String getDate = (cast.mediaType == 'movie')  ? cast.releaseDate : cast.firstAirDate;

    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
          DateTime.parse(getDate).year.toString(), 
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),   
        ),
    );
  }

  Widget _rateItem(CastAndCrew cast) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
      child: Row(
        children: <Widget>[
          Text(cast.voteAverage.toString(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Colors.orange[800]),),
          Icon(Icons.star, size: 18, color: Colors.orange[800], ) 
        ],
      ),
    );
  }

  Widget _infoCharacter(CastAndCrew cast){
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        'Character: ${cast.character}',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic
          ),
      ),
    );
  }

  Widget _infoEpisodeCount(CastAndCrew cast){

    if(cast.mediaType == 'movie'){
      return Container();
    }else{

       return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          'Episodes : ${cast.episodeCount}',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic
          ),
        ),
    );
    }
   
  }

   Widget _rowButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
         _buttonActions(Icons.keyboard_arrow_down, Colors.purpleAccent[400]), 
         
        ],
      ),
    );
  }

  Widget _buttonActions(IconData icon, Color color){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: Icon(
          icon, 
          size: 35.0, 
          color: color,
          ),
          onPressed: () {},
      ),
    );
  }
}


class PeopleCrewTab extends StatefulWidget {
 final int id;

 PeopleCrewTab({@required this.id});

  @override
  _PeopleCrewTabState createState() => _PeopleCrewTabState();
}

class _PeopleCrewTabState extends State<PeopleCrewTab> {
  

       


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PeopleInfoBloc>(context)
    ..add(GetCreditsPeople(widget.id));
    
  }
  
  @override
  Widget build(BuildContext context) {

    return Container(
      child: BlocBuilder<PeopleInfoBloc, PeopleInfoState>(
        builder: (context, state) {
          
          if(state is Empty){

            return LoadingCustomWidget();

          }else if(state is Loading){
            
            return LoadingCustomWidget();

          }else if(state is LoadedCreditsPeople){

            final List<CastAndCrew> listCrew = new List<CastAndCrew>.from(state.people.crew);

            return ListView.builder(
              itemCount: listCrew.length,
              itemBuilder: (context , i) => _buildCardItem(listCrew[i]),
            );

          }else if (state is Error){
             
             return Center(
              child: Text(state.message),
            );
          }
          return Center(
              child: Text('something Error'),
            );
        }
      )      
    ); 



    
  }

  Widget _buildCardItem(CastAndCrew cast) {

      final id = cast.id;
      final type = cast.mediaType;
      final String getTitle = (cast.mediaType == 'movie') ? cast.title : cast.name;

     return GestureDetector(
       onTap: (){
         Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(id, type, getTitle));
       },
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
         child: Container(
           child: _itemInfo(cast),
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
       ),
     ); 
  }

  Widget _itemInfo(CastAndCrew cast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _posterItem(cast),
        SizedBox(width: 6.0,),
        Expanded(child: _columnCenterItem(cast))
      ],
    );

  }

  Widget _columnCenterItem(CastAndCrew cast){
    return Container(
      child: Column(
        children: <Widget>[
          _rowInfoItem(cast),
          //SizedBox(height: 10.0,),
          _infoCharacter(cast),
          _infoEpisodeCount(cast),
          //SizedBox(height: 35.0,),
          _rowButtons(),
        ],
      ),
    );
  }

  Widget _rowInfoItem(CastAndCrew cast){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Expanded(child: _titleItem(cast), flex: 3, ),
        Spacer(),
        Expanded(child: _yearOfItem(cast), flex: 1,),
        Spacer(),
        Expanded(child: _rateItem(cast), flex: 2,)
        ],
      ),
    );
  }

  Widget _posterItem(CastAndCrew cast) {
    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/original${ cast.posterPath }');

    //! Agregar el Hero
    return Container(
      width: 110.0,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: (cast.posterPath == null) ? placeholder : poster ,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _titleItem(CastAndCrew cast) {

    final String getTitle = (cast.mediaType == 'movie') ? cast.title : cast.name;


    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
            getTitle, 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),
            overflow: TextOverflow.ellipsis,
          ),
    );
  }

  Widget _yearOfItem(CastAndCrew cast) {

    final String getDate = (cast.mediaType == 'movie') ? cast.releaseDate : cast.firstAirDate;

    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
          DateTime.parse(getDate).year.toString(), 
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),   
        ),
    );
  }

  Widget _rateItem(CastAndCrew cast) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
      child: Row(
        children: <Widget>[
          Text(cast.voteAverage.toString(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Colors.orange[800]),),
          Icon(Icons.star, size: 18, color: Colors.orange[800], ) 
        ],
      ),
    );
  }

  Widget _infoCharacter(CastAndCrew cast){
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        'Department: ${cast.job}',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic
          ),
      ),
    );
  }

  Widget _infoEpisodeCount(CastAndCrew cast){

    if(cast.mediaType == 'movie'){
      return Container();
    }else{

       return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          'Episodes : ${cast.episodeCount}',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic
          ),
        ),
    );
    }
   
  }

   Widget _rowButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
         _buttonActions(Icons.keyboard_arrow_down, Colors.purpleAccent[400]), 
         
        ],
      ),
    );
  }

  Widget _buttonActions(IconData icon, Color color){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: Icon(
          icon, 
          size: 35.0, 
          color: color,
          ),
          onPressed: () {},
      ),
    );
  }
}