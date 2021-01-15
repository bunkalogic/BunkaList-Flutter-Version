import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/circular_chart_rating.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/item_details_widget.dart';
import 'package:bunkalist/src/features/tops_favorites/presentation/widgets/container_top_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stack_card/flutter_stack_card.dart';


class BuildSatckedCardTopFavorites extends StatefulWidget {
  
  final String type;
  
  BuildSatckedCardTopFavorites({this.type});

  @override
  _BuildSatckedCardTopFavoritesState createState() => _BuildSatckedCardTopFavoritesState();
}

class _BuildSatckedCardTopFavoritesState extends State<BuildSatckedCardTopFavorites> {

  final Preferences prefs = Preferences();

   @override
  void initState() {
    super.initState();

    BlocProvider.of<GetListsBloc>(context)..add(
      GetYourLists( type: widget.type, status: ListProfileQuery.Favorite)
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetListsBloc, GetListsState>(
      builder: (context, state) {
        if(state is GetListsLoading){


          return Container(
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width / 0.80,
            child: LoadingCustomWidget()
          );


        }else if(state is GetListsLoaded){

         if(state.ouevreList.isEmpty){

           return _itemEmptyTopFavorites();
          
         } 
          _getTotalOfList(state.ouevreList.length);

          return StackedCardsWidget(ouevreList: state.ouevreList);


        }else if(state is GetlistsError){
          
          return _itemEmptyTopFavorites();

        }



        return _itemEmptyTopFavorites();

      },
    );
    
  }

  Widget _itemEmptyTopFavorites(){

    switch (widget.type) {
      case 'movie': return _itemMovieEmpty();
        break;

      case 'tv':  return _itemTVSeriesEmpty();
        break;

      case 'anime': return _itemAnimeEmpty();
        break;

      default:   return _itemMovieEmpty();
    }
  }

  void _getTotalOfList(int index){

    switch (widget.type) {
      case 'movie':{
        prefs.totalMoviesFav = index;
      }
      break;

      case 'tv':{
        prefs.totalSeriesFav = index;
      }
      break;

      case 'anime': {
        prefs.totalAnimesFav = index;
      }
      break;
    }
  }

  Widget _itemMovieEmpty(){
    return ContainerTopEmptyWidget(
          labelTitle: AppLocalizations.of(context).translate("empty_title_top_movie"),
          label: AppLocalizations.of(context).translate("empty_label_top_movie"), 
          dottedColor: Colors.redAccent[400],
          icon: Icons.star_rate_rounded,
          onTap: (){
            Navigator.pushNamed(context, '/TopFavCreate', arguments: getTypeAndMaxSelected( prefs.isNotAds ? 20 : 10, 'movie' ));
          },
        );
  }

  Widget _itemTVSeriesEmpty(){
    return ContainerTopEmptyWidget(
      labelTitle: AppLocalizations.of(context).translate("empty_title_top_serie"),
      label: AppLocalizations.of(context).translate("empty_label_top_serie"), 
      icon: Icons.star_rate_rounded, 
      dottedColor: Colors.greenAccent[400],
      onTap: (){
        Navigator.pushNamed(context, '/TopFavCreate', arguments: getTypeAndMaxSelected( prefs.isNotAds ? 20 : 10, 'tv' ));
      },
    );
  }

  Widget _itemAnimeEmpty(){
    return ContainerTopEmptyWidget(
      labelTitle: AppLocalizations.of(context).translate("empty_title_top_anime"),
      label: AppLocalizations.of(context).translate("empty_label_top_anime"), 
      dottedColor: Colors.blueAccent[400],
      icon: Icons.star_rate_rounded,
      onTap: (){
        Navigator.pushNamed(context, '/TopFavCreate', arguments: getTypeAndMaxSelected( prefs.isNotAds ? 20 : 10, 'anime' ));
      },
    );
  }
}



class StackedCardsWidget extends StatefulWidget {

  final List<OuevreEntity> ouevreList;

  StackedCardsWidget({@required this.ouevreList});

  @override
  _StackedCardsWidgetState createState() => _StackedCardsWidgetState();
}

class _StackedCardsWidgetState extends State<StackedCardsWidget> {
  
  int position = 0;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: (){
          print('on tap!!! position: $position');
          showDialog(
          context: context,
          builder: (context) {
            return Dialog(
            elevation: 5,
            backgroundColor: Colors.transparent,
            child: BuildItemDetailsWidget(ouevreEntity: widget.ouevreList[position]),
            );
          },
        ); 
          },
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width / 0.80,
            child: StackCard.builder(
              itemBuilder: (context, index) {
                return ItemStackCards(ouevreEntity: widget.ouevreList[index],);
              },
              onSwap: (value) {
                setState(() {
                  position = value;
                });
              },
              stackType: StackType.middle,
              stackOffset: const Offset(25.0, -10.0),
              dimension: StackDimension(
                height: MediaQuery.of(context).size.height * 0.38,
                width: MediaQuery.of(context).size.width / 0.85,
              ), 
              itemCount: widget.ouevreList.length
            ),
          ),
        ),
        _rowTopActions()
      ],
    );

  }


  Widget _rowTopActions() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10.0,),
            Expanded(
              flex: 1,
              child: RaisedButton(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Text(
                  AppLocalizations.of(context).translate("btn_label_view_top"),
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                ),
                color: Colors.pinkAccent[400],
                onPressed: (){
                  Navigator.pushNamed(context, '/TopFavDetails', arguments: widget.ouevreList);
                }
              ),
            ),
            SizedBox(width: 10.0,),
            Expanded(
              flex: 1,
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0), 
                  // side: BorderSide(
                  //   color: Colors.pinkAccent[400],
                  //   style: BorderStyle.solid,
                  //   width: 1.5
                  // )
                ),
                borderSide: BorderSide(
                  color: Colors.pinkAccent[400],
                  width: 1.5
                ),
                child: Text(
                  AppLocalizations.of(context).translate("btn_label_edit_top"),
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                ),
                color: Colors.pinkAccent[400],
                onPressed: (){
                  Navigator.pushNamed(context, '/TopFavEdit', arguments: widget.ouevreList);
                }
              ),
            ),
            SizedBox(width: 10.0,),
          ],
        ),
      ),
    );
  }

}

class ItemStackCards extends StatefulWidget {
  
  final OuevreEntity ouevreEntity;

  ItemStackCards({
    @required this.ouevreEntity,
  });

  @override
  _ItemStackCardsState createState() => _ItemStackCardsState();
}

class _ItemStackCardsState extends State<ItemStackCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          clipBehavior: Clip.antiAlias,
          children: [
            _cardItem(widget.ouevreEntity),
            _positionTopLabel(widget.ouevreEntity),
            _titleOfItem(widget.ouevreEntity),
            _ratingOfItem(widget.ouevreEntity)
          ],
        ),
      ),
    );
  }

  Widget _positionTopLabel(OuevreEntity item) {

    int position = item.positionListFav;
    String label = '${position.toString()}.';

    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
          left: 20.0
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 2.0,
              )
            ]
          ),
        ),
      )
    );
  }

  Widget _titleOfItem(OuevreEntity item) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 30.0,
          left: 65.0,
          right: 10.0
        ),
        child: Text(
          item.oeuvreTitle,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 2.5,
              )
            ]
          ),
        ),
      )
    );
  }

  Widget _cardItem(OuevreEntity item) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage(item.oeuvrePoster);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: FadeInImage(
          placeholder: placeholder, 
          image: poster,
          fit: BoxFit.fill,
        ),
      ), 
    );
  }

  Widget _ratingOfItem(OuevreEntity item) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BigFavoriteCircularChartRating(item.finalRate),
      )
    );
  }
}
