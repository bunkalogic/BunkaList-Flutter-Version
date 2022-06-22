import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/circular_chart_rating.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/emptys_list_profile_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/item_watching_details_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/update_and_delete_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/watching_progress_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class TabItemWatchingWidget extends StatefulWidget {
  
  final String type; 
  final ListProfileQuery status;

  const TabItemWatchingWidget({
    @required this.type,
    @required this.status
  });
  

  @override
  _TabItemWatchingWidgetState createState() => _TabItemWatchingWidgetState();
}

class _TabItemWatchingWidgetState extends State<TabItemWatchingWidget> {


  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetListsBloc>(context)..add(
      GetYourLists( type: widget.type, status: widget.status)
    );
  }

   

  double cardSize = 100.0;

  final styleAllRates = TextStyle(
    color: Colors.white,
    fontSize: 16.0, 
    fontWeight: FontWeight.w700,
    shadows: [
      Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
      ]
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetListsBloc, GetListsState>(
      builder: (context, state) {
        if(state is GetListsLoading){
          
          return LoadingCustomWidget();

        }else if(state is GetListsLoaded){

          if(state.ouevreList.isEmpty){

            return ListProfileEmptyIconWidget(
            title: AppLocalizations.of(context).translate("watching_empty_label"),
            color: Colors.blueAccent[400],
            icon: Icons.play_circle_outline,
            );

          }

          return Container(
      child: ListView.builder(
        itemExtent: cardSize,
        itemCount: state.ouevreList.length,
        itemBuilder: (context, i) => _itemTab(state.ouevreList[i])
        ),
    );

        }else if(state is GetlistsError){
          
          return ListProfileEmptyIconWidget(
            title: AppLocalizations.of(context).translate("watching_empty_label"),
            color: Colors.blueAccent[400],
            icon: Icons.play_circle_outline,
          );

        }

        return ListProfileEmptyIconWidget(
            title: AppLocalizations.of(context).translate("watching_empty_label"),
            color: Colors.blueAccent[400],
            icon: Icons.play_circle_outline,
          );

      },
    );
  }

  Widget _itemTab(OuevreEntity ouevre) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      curve: Curves.decelerate,
      height: cardSize,
      child: GestureDetector(
        onTap: (){
          
          


           if(ouevre.oeuvreType == "movie"){
             Navigator.pushNamed(
               context, '/AllDetails', 
               arguments: 
               getIdAndType(
                 ouevre.oeuvreId, 
                 ouevre.oeuvreType,  
                 ouevre.oeuvreTitle)
             );
           }else{
             showDialog(
             context: context,
             builder: (_) {
               return Dialog(
               insetPadding: const EdgeInsets.symmetric(
                 horizontal: 30.0,
                 vertical: 30.0
               ),  
               elevation: 5,
               backgroundColor: Colors.transparent,
               child: BuildItemWatchingDetailsWidget(ouevreEntity: ouevre),
               );
             },
           ); 
           }

          
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0 ),
          borderOnForeground: false,
          child: Stack(
           fit: StackFit.expand, 
           children: <Widget>[
             _imageBackground(ouevre),
             _gradientBackground(),
             _listTileInfoItem(ouevre),
             _buttomExtend(ouevre),
             ouevre.status == 2 ? BlocProvider<OuevreDetailsBloc>(
            create: (_) => serviceLocator<OuevreDetailsBloc>(),
            child: WatchingProgressBar(ouevreEntity: ouevre,)
          )
          :SizedBox.shrink(),
             
           ],
          ),
        ),
      ),
    );
  }

  Widget _imageBackground(OuevreEntity ouevre) {
    return Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage(
            image: NetworkImage(ouevre.oeuvrePoster),
            placeholder: AssetImage('assets/poster_placeholder.png'),
            fit: BoxFit.cover,
          ),
        ),
      );
  }

  Widget _gradientBackground() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
          begin: Alignment.centerRight,
          end: Alignment.center,
          colors: [
            Colors.blueGrey[100].withOpacity(0.1),
            Colors.blueGrey[200].withOpacity(0.2),
            Colors.blueGrey[300].withOpacity(0.3),
            Colors.blueGrey[400].withOpacity(0.4),
            Colors.blueGrey[500].withOpacity(0.5),
            Colors.blueGrey[600].withOpacity(0.6),
            
          ]
        ) 
      ), 
    );
  }

  Widget _listTileInfoItem(OuevreEntity ouevre){
    return ListTile(
      leading: MiniCircularChartRating(ouevre.oeuvreRating),
      title: _titleItem(ouevre),
      trailing: _itemDate(ouevre),
      // subtitle: _rowInfoSeasonAndEpisode(ouevre),
      
    );

  }

  Widget _titleItem(OuevreEntity ouevre) {
    return Text(
      ouevre.oeuvreTitle,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        shadows: [
          Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
        ]
      ),
    );
  }

  Widget _itemRate() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.stars, color: Colors.pink,),
        Text('-.-', 
        style: TextStyle(
          fontSize: 14.0, 
          fontWeight: FontWeight.w900, 
          color: Colors.pink,
          shadows: [
          Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          )
        ),
        
      ],
    );
  }

  Widget _itemDate(OuevreEntity ouevre) {

    final DateTime datetime = ouevre.addDate;

    final formatter = DateFormat('dd-MM-yy');

    final date = formatter.format(datetime);


    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.today_rounded, color: Colors.pink,),
        Text(date, 
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0, 
          fontWeight: FontWeight.w800,
          shadows: [
          Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          )
          ),       
      ],
    );
  }

  Widget _buttomExtend(OuevreEntity ouevre) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom:10.0),
        child: IconButton(
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.pinkAccent[400], size: 35.0,),
          onPressed: (){
            
            ButtomUpdateAndDelete(
                type: ouevre.oeuvreType,
                ouevre: ouevre,
              ).showBottonModalOptions(context);
          },
        ),
      ),
    );
  }

  _rowInfoSeasonAndEpisode(OuevreEntity ouevre){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _subTitleSeasonInfo(ouevre),
        _threeTitleEpisodeInfo(ouevre)
      ],
    );
  }

  Widget _subTitleSeasonInfo(OuevreEntity ouevre) {

    if(ouevre.oeuvreType == "movie") return Container();

    final String season = AppLocalizations.of(context).translate("season");

    final String watchSeason = ouevre.seasons.toString();
    
    return Text(
      '$season : $watchSeason',
       style: TextStyle(
          color: Colors.white,
          fontSize: 14.0, 
          fontWeight: FontWeight.w800,
          shadows: [
          Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          ) 
      );
  }

  Widget _threeTitleEpisodeInfo(OuevreEntity ouevre) {

    if(ouevre.oeuvreType == "movie") return Container();
    
    final String episode = AppLocalizations.of(context).translate("episode");

    final String watchEpisode = ouevre.episodes.toString();

    return Text(
      '$episode : $watchEpisode',
       style: TextStyle(
          color: Colors.white,
          fontSize: 14.0, 
          fontWeight: FontWeight.w800,
          shadows: [
          Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          ) 
      );
  }
}
