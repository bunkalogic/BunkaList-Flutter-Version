import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/reusable_widgets/circular_chart_rating.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_credits_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_people/bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
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

            if(state.people.cast == null || state.people.cast.isEmpty) return EmptyIconWidget();

            final List<CastAndCrew> listCast = new List<CastAndCrew>.from(state.people.cast);

            final List<CastAndCrew> listCastOrder = reOrderListForYear(listCast);

            return ListView.builder(
              itemExtent: 165.0,
              itemCount: listCastOrder.length,
              itemBuilder: (context , i) => BuildItemCrewAndCastWidget(cast: listCastOrder[i]),
            );

          }else if (state is Error){
             
             return EmptyIconWidget();
          }
          return EmptyIconWidget();
        }
      )      
    ); 



    
  }


  List<CastAndCrew> reOrderListForYear(List<CastAndCrew> listCast){
    
    List<CastAndCrew> listReOrder = listCast;

     listReOrder.sort(
      (a, b) {

        final String getDateA = (a.firstAirDate == null) ? a.releaseDate : a.firstAirDate;
        final String getDateB = (b.firstAirDate == null) ? b.releaseDate : b.firstAirDate;

        final String getRealDateA = getDateA.isEmpty ? '2023-12-31' : getDateA;
        final String getRealDateB = getDateB.isEmpty ? '2023-12-31' : getDateB;

        final String dateA = DateTime.parse(getRealDateA).year.toString();
        final String dateB = DateTime.parse(getRealDateB).year.toString();

        return dateB.compareTo(dateA);

      } 
    );

    return listReOrder;  

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

            if(state.people.crew == null || state.people.crew.isEmpty) return EmptyIconWidget();

            final List<CastAndCrew> listCast = new List<CastAndCrew>.from(state.people.crew);

            final List<CastAndCrew> listCrewOrder = reOrderListForYear(listCast);

            

            return ListView.builder(
              itemExtent: 165.0,
              itemCount: listCrewOrder.length,
              itemBuilder: (context , i) => BuildItemCrewAndCastWidget(cast: listCrewOrder[i]),
            );

          }else if (state is Error){
             
             return EmptyIconWidget();
          }
          return EmptyIconWidget();
        }
      )      
    ); 

    
  }


  List<CastAndCrew> reOrderListForYear(List<CastAndCrew> listCast){
    
    List<CastAndCrew> listReOrder = listCast;

     listReOrder.sort(
      (a, b) {

        final String getDateA = (a.firstAirDate == null) ? a.releaseDate : a.firstAirDate;
        final String getDateB = (b.firstAirDate == null) ? b.releaseDate : b.firstAirDate;

        final String getRealDateA = getDateA.isEmpty ? '2023-12-31' : getDateA;
        final String getRealDateB = getDateB.isEmpty ? '2023-12-31' : getDateB;

        final String dateA = DateTime.parse(getRealDateA).year.toString();
        final String dateB = DateTime.parse(getRealDateB).year.toString();

        return dateB.compareTo(dateA);

      } 
    );

    return listReOrder;  

  }

  
}





class BuildItemCrewAndCastWidget extends StatefulWidget {

  final CastAndCrew cast;

  BuildItemCrewAndCastWidget({@required this.cast});

  @override
  _BuildItemCrewAndCastWidgetState createState() => _BuildItemCrewAndCastWidgetState();
}

class _BuildItemCrewAndCastWidgetState extends State<BuildItemCrewAndCastWidget> {
  @override
  Widget build(BuildContext context) {

      final id = widget.cast.id;
      final type = widget.cast.mediaType;
      final String getTitle = (widget.cast.mediaType == 'movie') ? widget.cast.title : widget.cast.name;

     return GestureDetector(
       onTap: (){
         Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(id, type, getTitle));
       },
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
         child: Container(
           child: _itemInfo(),
           height: 165.0,
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

  

  Widget _itemInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _posterItem(),
        SizedBox(width: 6.0,),
        Expanded(child: _columnCenterItem())
      ],
    );

  }

  Widget _columnCenterItem(){
    return Container(
      child: Column(
        children: <Widget>[
          _rowInfoItem(),
          Expanded(child: _infoCharacter()),
          Expanded(child: _infoEpisodeCount()),
          Expanded(child: _rowButtons()),
        ],
      ),
    );
  }

  Widget _rowInfoItem(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Expanded(child: _titleItem(), flex: 3, ),
        Spacer(),
        Expanded(child: _yearOfItem(), flex: 1,),
        Spacer(),
        Expanded(child: _rateItem(), flex: 2,)
        ],
      ),
    );
  }

  Widget _posterItem() {
    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ widget.cast.posterPath }');

    //! Agregar el Hero
    return Container(
      width: 110.0,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: (widget.cast.posterPath == null) ? placeholder : poster ,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _titleItem() {

    final String getTitle = (widget.cast.mediaType == 'movie') ? widget.cast.title : widget.cast.name;


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

  Widget _yearOfItem() {

    final String getDate = (widget.cast.mediaType == 'movie') ? widget.cast.releaseDate : widget.cast.firstAirDate;

    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
          (getDate.isNotEmpty) ? DateTime.parse(getDate).year.toString() : "no date", 
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),   
        ),
    );
  }

  Widget _rateItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 1.5),
      child: MiniCircularChartRating(widget.cast.voteAverage)
    );
  }

  Widget _infoCharacter(){
    
    String role = widget.cast.character == null ? widget.cast.job : widget.cast.character;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        'Role: $role',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic
          ),
      ),
    );
  }

  Widget _infoEpisodeCount(){

    if(widget.cast.mediaType == 'movie'){
      return Container();
    }else{

       return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          'Episodes : ${widget.cast.episodeCount}',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic
          ),
        ),
    );
    }
   
  }

   Widget _rowButtons() {
    return BlocProvider<AddOuevreBloc>(
          create: (_) => serviceLocator<AddOuevreBloc>(),
          child: MultiButtonsAdded(ouevre: widget.cast, type: widget.cast.mediaType, objectType: ConstantsTypeObject.castAndCrew,),
        );
  }

  
}