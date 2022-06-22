import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/credits_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_credits/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDetailsCastingTab extends StatefulWidget {

  final int id;
  final String type;

  AllDetailsCastingTab({@required this.id, @required this.type});  

  @override
  _AllDetailsCastingTabState createState() => _AllDetailsCastingTabState();
}

class _AllDetailsCastingTabState extends State<AllDetailsCastingTab> with AutomaticKeepAliveClientMixin {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<CreditsBloc>(context)
    ..add(GetDetailsCredits(widget.id, widget.type));
    
  }  


  @override
  Widget build(BuildContext context) {

    super.build(context);

    return Container(
      child: BlocBuilder<CreditsBloc, CreditsState>(
        builder: (context, state) {
          
          if(state is Empty){

            return Container(
              height: 250.0,
              child: LoadingCustomWidget());

          }else if(state is Loading){
            
            return Container(
              height: 250.0,
              child: LoadingCustomWidget());

          }else if(state is Loaded){

            final credits = state.credits;

            final List<Cast> listCast = new List<Cast>.from(credits.cast);
            final List<Crew> listCrew = new List<Crew>.from(credits.crew);  

            return Container(
              child: Column(
                children: <Widget>[
                  BigContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/4251997510',),
                  _titleSection(AppLocalizations.of(context).translate('casting')),
                  ScrollCastItem(castList: listCast,),
                  _titleSection(AppLocalizations.of(context).translate('crew')),
                  ScrollCrewItem(crewList: listCrew,),
                  
                  //MaxNativeAds(adPlacementID: "177059330328908_179581390076702",),
                ],
              )
            );

          }else if(state is Error){
            
            return EmptyIconWidget();

          }

          return EmptyIconWidget();

        },
      ),
    );
  }


  Widget _titleSection(String title){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 30),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
  

  
  Widget _labelScrollPersonItem(String label){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  
}

class ScrollCastItem extends StatelessWidget{
  
  final List<Cast> castList;

  ScrollCastItem({@required this.castList});


  @override
  Widget build(BuildContext context) {

    if(castList.isEmpty || castList.length <= 0){
      return Container(
        child: Center(
          child: Text('No Info Available'),
        ),
      );
    }else{
      return Container(
        height: 250.0,
        width: double.infinity,
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          scrollDirection: Axis.horizontal,
          itemCount: castList.length,
          itemBuilder: (context, i)=> _personItem(context, castList[i]),
        ),
    );
    }    
  }

  Widget _personItem(BuildContext context, Cast cast){
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/AllDetailsPeople', arguments: getIdAndNameCast(cast.id, cast.name)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child: Column(
          children: <Widget>[
            // _personPhotoItem(cast),
            _peopleImage(cast),
            SizedBox(height: 10.0,),
            _columnName(cast),
          ],
        ),
      ),
    );
  }


  Widget _peopleImage(Cast cast) {

    final placeholder = AssetImage('assets/photo-placeholder.png');
    final photo = NetworkImage('https://image.tmdb.org/t/p/original${cast.profilePath}');

    return Container(
      padding: const EdgeInsets.only(top:10.0),
      child: Container(
        width:  109.3,
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
              image: (cast.profilePath == null) ? placeholder : photo,//? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.contain,
            ),
          ),
      ),
    );

    
  }

  Widget _personPhotoItem(Cast cast) {
    final placeholder = AssetImage('assets/photo-placeholder.png');
    final photo = NetworkImage('https://image.tmdb.org/t/p/w185${cast.profilePath}');

    if(cast.profilePath == null){
       return Container(
        child: CircleAvatar(
          radius: 45.0,
          backgroundImage: placeholder,
        ),
      );

    }else{
       return Container(
        child: CircleAvatar(
          radius: 45.0,
          backgroundImage: photo ,
        ),
      );
    }
  }

   

  Widget _columnName(Cast cast) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(cast.name, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),),
          Text(cast.character, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey),),
        ],
      ),
    );
  }

}

class ScrollCrewItem extends StatelessWidget{
  
  final List<Crew> crewList;

  ScrollCrewItem({@required this.crewList});


  @override
  Widget build(BuildContext context) {

    if(crewList.isEmpty || crewList.length <= 0){
      return Container(
        child: Center(
          child: Text('No Info Available'),
        ),
      );
    }else{

      return Container(
        height: 265.0,
        width: double.infinity,
        child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        scrollDirection: Axis.horizontal,
        itemCount: crewList.length,
        itemBuilder: (context, i)=> _personItem(context, crewList[i]) ,
      ),
      );

    }

    
  }


  Widget _personItem(BuildContext context, Crew crew){
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/AllDetailsPeople', arguments: getIdAndNameCast(crew.id, crew.name)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child: Column(
          children: <Widget>[
            // _personPhotoItem(crew),
            _peopleImage(crew),
            SizedBox(height: 10.0,),
            _columnName(crew),
          ],
        ),
      ),
    );
  }


  Widget _peopleImage(Crew crew) {

    final placeholder = AssetImage('assets/photo-placeholder.png');
    final photo = NetworkImage('https://image.tmdb.org/t/p/original${crew.profilePath}');

    return Container(
      padding: const EdgeInsets.only(top:10.0),
      child: Container(
        width: 109.3,
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
              image: (crew.profilePath == null) ? placeholder : photo,//? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.contain,
            ),
          ),
      ),
    );

    
  }

  Widget _personPhotoItem(Crew crew) {
    final placeholder = AssetImage('assets/photo-placeholder.png');
    final photo = NetworkImage('https://image.tmdb.org/t/p/w185/${crew.profilePath}');

    if(crew.profilePath == null){
       return Container(
        child: CircleAvatar(
          radius: 45.0,
          backgroundImage: placeholder,
        ),
      );

    }else{
       return Container(
        child: CircleAvatar(
          radius: 45.0,
          backgroundImage: photo ,
        ),
      );
    }
  }

  Widget _columnName(Crew crew) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(crew.name, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),),
          Text(crew.job, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey),),
          Text(crew.department, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.grey[400]),),
        ],
      ),
    );
  }

}