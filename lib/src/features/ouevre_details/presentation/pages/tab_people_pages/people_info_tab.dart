import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/format_date.dart';
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
          _peopleImage(people),
          _peopleName(people),
          _peopleDate(people),
          new BlocProvider<PeopleInfoBloc>(
          create: (_) => serviceLocator<PeopleInfoBloc>(),
          child: ContainerSocialMedia(id: widget.id,),
        ),
          _cardInfoPeople(people),
        
        ],
      ),
    );
  }

  Widget _peopleImage(PeopleEntity people) {

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://image.tmdb.org/t/p/w185/${people.profilePath}'),
          radius: 60.0,
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
          fontSize: 24.0,
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
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600
        ),
        textAlign: TextAlign.center,
        ),
    );
  }

  

  Widget _cardInfoPeople(PeopleEntity people) {
    if(people.biography.isEmpty) return Container();

    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: _columnBiography(people),
    );
  }

  Widget _columnBiography(PeopleEntity people) {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //_labelBio(),
          _textBio(people)
        ],
      ),
    );
  }

  Widget _labelBio() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
            'Biography :',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600
            ),
          ),
    );
  }

  Widget _textBio(PeopleEntity people) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0 ),
      child: Text(
        people.biography,
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16.0),
        textAlign: TextAlign.justify,
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

            return Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
            children: <Widget>[
              _iconSocialMediaFacebook(state.peopleSocialMedia.facebookId),
              _iconSocialMediaTwitter(state.peopleSocialMedia.twitterId),
              _iconSocialMediaInstagram(state.peopleSocialMedia.instagramId)
            ],
          ),
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

    final url = 'https://www.facebook.com/$socialId';
    return GestureDetector(
      onTap:() => launch(url) ,
      child: Image(image: AssetImage('assets/icons8-facebook.png'), height: 50.0,),
    );

  }

  Widget _iconSocialMediaTwitter(String socialId){

    final url = 'https://twitter.com/$socialId';
    return GestureDetector(
      onTap:() => launch(url) ,
      child: Image(image: AssetImage('assets/icons8-twitter.png'),height: 50.0,),
    );

  }

  Widget _iconSocialMediaInstagram(String socialId){

    final url = 'https://www.instagram.com/$socialId';
    return GestureDetector(
      onTap:() => launch(url) ,
      child: Image(image: AssetImage('assets/icons8-instagram.png'), height: 50.0,),
    );

  }
}


