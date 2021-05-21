import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/format_date.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_credits_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_social_media_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_people/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../injection_container.dart';

class PeopleInfoTab extends StatefulWidget {

  final int id;
  PeopleInfoTab({@required this.id});

  @override
  _PeopleInfoTabState createState() => _PeopleInfoTabState();
}

class _PeopleInfoTabState extends State<PeopleInfoTab> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PeopleInfoBloc>(context)
    ..add(GetDetailsPeople(widget.id));
    
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

          }else if(state is LoadedDetailsPeople){

            return _containerInfoPeople(state.people);

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

  

  Widget _containerInfoPeople(PeopleEntity people) {



      return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          _columnOfPeopleBasicInfo(people),
          new BlocProvider<PeopleInfoBloc>(
            create: (_) => serviceLocator<PeopleInfoBloc>(),
            child: ContainerSocialMedia(id: widget.id,),
          ),
          _overviewInfo(people),
          SizedBox(height: 20.0,),
          _titleSection(AppLocalizations.of(context).translate('sort_popular')),
          SizedBox(height: 20.0,),
          new BlocProvider<PeopleInfoBloc>(
            create: (_) => serviceLocator<PeopleInfoBloc>(),
            child: BuildKnowForListWidget(id: widget.id, isActing: people.knownForDepartment == 'Acting' ? true : false,),
          ),
        
        ],
      ),
    );
  }

  Widget _titleSection(String title){
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 30),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _overviewInfo(PeopleEntity people) {
    if( people.biography == null || people.biography.isEmpty) return Container();

    final _overviewStyle = new TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 16.0,
      fontWeight: FontWeight.w500
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
      child: Text( people.biography,
        style: _overviewStyle,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _columnOfPeopleBasicInfo(PeopleEntity people){
    return Column(
      children: [
        _peopleImage(people),
        _peopleName(people),
        _peopleKnowDeparment(people),
        _peoplePlaceOfBirth(people),
        _peopleDate(people),
        
      ],
    );
  }

  Widget _peopleImage(PeopleEntity people) {

    final placeholder = AssetImage('assets/photo-placeholder.png');
    final photo = NetworkImage('https://image.tmdb.org/t/p/original${people.profilePath}');

    return Container(
      padding: const EdgeInsets.only(top:15.0),
      child: Container(
        width: 111.0,
        height: 160.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400].withOpacity(0.4),
              blurRadius: 0.5,
              spreadRadius: 0.5
            ),
          ]
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FadeInImage(
              image: (people.profilePath == null) ? placeholder : photo,//? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.contain,
            ),
          ),
      ),
    );

    
  }

  Widget _peopleName(PeopleEntity people) {


    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        people.name,
        style: TextStyle(
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w800
        ),
        textAlign: TextAlign.center,
        ),
    );
  }

  Widget _peopleDate(PeopleEntity people) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        formatterDate(people.birthday),
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey
        ),
        textAlign: TextAlign.center,
        ),
    );
  }

  Widget _peoplePlaceOfBirth(PeopleEntity people) {

    if(people.placeOfBirth == null) return SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        people.placeOfBirth,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey
        ),
        textAlign: TextAlign.center,
        ),
    );
  }

  Widget _peopleKnowDeparment(PeopleEntity people) {

    if(people.knownForDepartment == null) return SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        people.knownForDepartment,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey
        ),
        textAlign: TextAlign.center,
        ),
    );
  }

  



  

  

 
}


class ContainerSocialMedia extends StatefulWidget{
  
  final int id;
  ContainerSocialMedia({@required this.id});

  @override
  _ContainerSocialMediaState createState() => _ContainerSocialMediaState();
}

class _ContainerSocialMediaState extends State<ContainerSocialMedia> {


  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PeopleInfoBloc>(context)
    ..add(GetSocialMediaPeople(widget.id));
    
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

          }else if(state is LoadedSocialMediaPeople){

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _iconSocialMediaFacebook(state.peopleSocialMedia.facebookId),
                _iconSocialMediaTwitter(state.peopleSocialMedia.twitterId),
                _iconSocialMediaInstagram(state.peopleSocialMedia.instagramId)
              ],
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

  Widget _iconSocialMediaFacebook(String socialId){

    if(socialId == null || socialId == '') return SizedBox.shrink();

    final url = 'https://www.facebook.com/$socialId';
    return GestureDetector(
      onTap:() => launch(url) ,
      child: Image(image: AssetImage('assets/icons8-facebook.png'), height: 40.0,),
    );

  }

  Widget _iconSocialMediaTwitter(String socialId){

    if(socialId == null || socialId == '') return SizedBox.shrink();

    final url = 'https://twitter.com/$socialId';
    return GestureDetector(
      onTap:() => launch(url) ,
      child: Image(image: AssetImage('assets/icons8-twitter.png'),height: 40.0,),
    );

  }

  Widget _iconSocialMediaInstagram(String socialId){

     if(socialId == null || socialId == '') return SizedBox.shrink();

    final url = 'https://www.instagram.com/$socialId';
    return GestureDetector(
      onTap:() => launch(url) ,
      child: Image(image: AssetImage('assets/icons8-instagram.png'), height: 40.0,),
    );

  }
}



class BuildKnowForListWidget extends StatefulWidget {
  
  final int id;
  final bool isActing;
  BuildKnowForListWidget({
    @required this.id,
    @required this.isActing
  });
  
  

  @override
  _BuildKnowForListWidgetState createState() => _BuildKnowForListWidgetState();
}

class _BuildKnowForListWidgetState extends State<BuildKnowForListWidget> {
  
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PeopleInfoBloc>(context)
    ..add(GetCreditsPeople(widget.id));
    
  }
  
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 280.0,
      child: BlocBuilder<PeopleInfoBloc, PeopleInfoState>(
        builder: (context, state) {
          
          if(state is Empty){

            return LoadingCustomWidget();

          }else if(state is Loading){
            
            return LoadingCustomWidget();

          }else if(state is LoadedCreditsPeople){

            List<CastAndCrew> listCast = [];

            if(widget.isActing){

             if(state.people.cast == null || state.people.cast.isEmpty) return EmptyIconWidget();

             listCast = new List<CastAndCrew>.from(state.people.cast); 

            }else{

              if(state.people.crew == null || state.people.crew.isEmpty) return EmptyIconWidget();

              listCast = new List<CastAndCrew>.from(state.people.crew);

            }


            final List<CastAndCrew> listCrewOrder = reOrderListForPopularity(listCast);

            

            return ListView.builder(
              itemExtent: 180.0,
              itemCount: listCrewOrder.length <= 5 ? listCrewOrder.length : 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context , i) => BuildItemPosterCrewAndCastWidget(cast: listCrewOrder[i]),
            );

          }else if (state is Error){
             
             return EmptyIconWidget();
          }
          return EmptyIconWidget();
        }
      )      
    ); 

  }


   List<CastAndCrew> reOrderListForPopularity(List<CastAndCrew> listCast){

    listCast.sort(
      (a, b){

        return b.popularity.compareTo(a.popularity);

      }
    );
    

    return listCast;

   }
}



class BuildItemPosterCrewAndCastWidget extends StatefulWidget {


  final CastAndCrew cast;


  BuildItemPosterCrewAndCastWidget({@required this.cast});

  @override
  _BuildItemPosterCrewAndCastWidgetState createState() => _BuildItemPosterCrewAndCastWidgetState();
}

class _BuildItemPosterCrewAndCastWidgetState extends State<BuildItemPosterCrewAndCastWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: _itemImageAndRating(context,), flex: 4,),
            _itemTitle(),
            SizedBox(height: 5.0,),
            _itemRole(),
            Expanded(child: _iconButton(context,), flex: 1,),
            SizedBox(height: 20.0,),
          ],
      ),
    );
  }

   Widget _itemImageAndRating(BuildContext context){
    return Container(
      child: Stack(
        children: <Widget>[
          _itemImage(context),
          _itemRating()
        ],
      ),
    );
  }

  Widget _itemRating(){
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[400].withOpacity(0.3)
      ),
      child: Text(
        widget.cast.voteAverage.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w800,
          shadows: [
           Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          ),
      ),
    );
  }

  Widget _itemImage(BuildContext context,) {

    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ widget.cast.posterPath }');

    
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (widget.cast.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.cover,
              width: 120.0,
              height: 180,
            ),
          );

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.4),
                blurRadius: 0.5,
                spreadRadius: 0.5
              ),
            ]
          ),
      child: GestureDetector(
          onTap: (){
            //! PushNamed Al ItemAllDetail
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(widget.cast.id, widget.cast.mediaType,  widget.cast.name));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            widget.cast.name == null ? widget.cast.title : widget.cast.name,
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _itemRole() {

    String role = widget.cast.character == null ? widget.cast.job : widget.cast.character;

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            'Role: $role',
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w500, color: Colors.grey),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context){

    return ButtonAddedArrowDown(ouevre: widget.cast, type: widget.cast.mediaType, isUpdated: false, objectType: ConstantsTypeObject.castAndCrew,);
        
  }
}