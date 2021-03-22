import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/circular_chart_rating.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/build_bottom_modal_filter_completed.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/emptys_list_profile_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/item_details_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/update_and_delete_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class TabItemCompletedWidget extends StatefulWidget {

  

  final String type; 
  // final ListProfileQuery status;

  const TabItemCompletedWidget({
    @required this.type,
    // @required this.status
  });

  @override
  _TabItemCompletedWidgetState createState() => _TabItemCompletedWidgetState();
}

class _TabItemCompletedWidgetState extends State<TabItemCompletedWidget> {

  final prefs = new Preferences();
  ListProfileQuery status;
  bool isExtended = false;

  @override
  void initState() {
    super.initState();

    // setState(() {
    //   status = prefs.getfilterListCompleted;
    // });

    BlocProvider.of<GetListsBloc>(context)..add(
      GetYourLists( type: widget.type, status: ListProfileQuery.Completed)
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
            title: AppLocalizations.of(context).translate("completed_empty_label"),
            color: Colors.greenAccent[400],
            icon: Icons.check_circle_outline,
          );
          
         } 

          return _buildListView(state.ouevreList);


        }else if(state is GetlistsError){
          
          return ListProfileEmptyIconWidget(
            title: AppLocalizations.of(context).translate("completed_empty_label"),
            color: Colors.greenAccent[400],
            icon: Icons.check_circle_outline,
          );

        }



        return ListProfileEmptyIconWidget(
            title: AppLocalizations.of(context).translate("completed_empty_label"),
            color: Colors.greenAccent[400],
            icon: Icons.check_circle_outline,
          );

      },
    );

    
    
  }

  Widget _buildListView(List<OuevreEntity> ouevreList){

    return Scaffold(
      body: Container(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollStartNotification) {
              // Handle your desired action on scroll start here.
              setState(() {
                isExtended = true;
              });
            }

            if (notification is ScrollEndNotification) {
              // Handle your desired action on scroll start here.
              setState(() {
                isExtended = false;
              });
            }

            // Returning null (or false) to
            // "allow the notification to continue to be dispatched to further ancestors".
            return null;
          },
          child:  ListView.builder(
            itemExtent: cardSize,
            itemCount: ouevreList.length,
            itemBuilder: (context, i) => _itemTab(ouevreList[i])
          ),
        )
      ),
      floatingActionButton:  _buildExtendFab(), 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );

  }

  

  Widget _buildExtendFab(){
    return FloatingActionButton.extended(
        elevation: 10.0,
        backgroundColor: _getBackgroundColorTheme(),
        onPressed:() async {


          if(prefs.isNotAds){
            ListProfileQuery result = await showModalBottomSheet<ListProfileQuery>(
              isScrollControlled: true,
              elevation: 10.0,
              isDismissible: false,
              backgroundColor: _getBackgroundColorTheme(), 
              context: context,
              builder: (_) => BuildBottomFilterCompleted(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30)
                )
              )
            );

          status = result;
          setState(() {});

          BlocProvider.of<GetListsBloc>(context)..add(
            GetYourLists( type: widget.type, status: result ?? ListProfileQuery.Completed )
          );
          }else{
            Navigator.pushNamed(context, '/Premium');
          }

          

        },
        label: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(
            opacity: animation,
            child: SizeTransition(child:
            child,
              sizeFactor: animation,
              axis: Axis.horizontal,
            ),
          ) ,
          child: isExtended 
          ? Icon(
            Icons.filter_list,
            color: Colors.pinkAccent[400],
          )
          : Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 1.0),
                child: Icon(
                  Icons.filter_list,
                  color: Colors.pinkAccent[400],
                ),
              ),
              Text(
                AppLocalizations.of(context).translate("order_by"),
                style: TextStyle(
                  color: Colors.pinkAccent[400],
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700
                ),
              )
            ],
          ),
        )
      );
  }

  Color _getBackgroundColorTheme() {
    final prefs = new Preferences();

    if(prefs.whatModeIs && prefs.whatDarkIs == false){
      return Colors.blueGrey[900];
    }else if(prefs.whatModeIs && prefs.whatDarkIs == true){
      return Colors.grey[900];
    }
    else{
      return Colors.grey[100];
    }
  }

  Widget _itemTab(OuevreEntity ouevre) {
    return Hero(
      tag: ouevre.oeuvreId,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        curve: Curves.decelerate,
        height: cardSize,
        child: GestureDetector(
          onTap: (){
            
            // Navigator.pushNamed(
            //     context, '/AllDetails', 
            //     arguments: 
            //     getIdAndType(
            //       ouevre.oeuvreId, 
            //       ouevre.oeuvreType,  
            //       ouevre.oeuvreTitle)
            //   );

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
              child: BuildItemDetailsWidget(ouevreEntity: ouevre),
              );
            },
          ); 
           

          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            elevation: 5.0,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0 ),
            borderOnForeground: false,
            child: Stack(
             fit: StackFit.expand, 
             children: <Widget>[
               _imageBackground(ouevre),
               _gradientBackground(ouevre),
               _listTileInfoItem(ouevre),
               _buttomExtend(ouevre),
               //_showAllRating(ouevre),
               
             ],
            ),
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

  Widget _gradientBackground(OuevreEntity ouevre) {
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
      leading: _itemRate(ouevre),
      title: _titleItem(ouevre),
      trailing: _itemDate(ouevre),
      contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0 ),
    );

  }

  Widget _titleItem(OuevreEntity ouevre) {
    return Text(
      ouevre.oeuvreTitle,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        shadows: [
          Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
        ]
      ),
    );
  }

  Widget _itemRate(OuevreEntity ouevre) {
    if(ouevre.isFavorite != null && ouevre.isFavorite){
      return MiniFavoriteCircularChartRating(_getRatingActualFilter(ouevre));
    }
    return MiniCircularChartRating(_getRatingActualFilter(ouevre));
  }

  Widget _itemDate(OuevreEntity ouevre) {

    final DateTime datetime = ouevre.addDate;

    final formatter = DateFormat('dd-MM-yy');

    final date = formatter.format(datetime);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.today, color: Colors.pink,),
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
      child: IconButton(
        icon: _changedIcon(),
        autofocus: true,
        onPressed: (){
          // _changedSizedCard();
          ButtomUpdateAndDelete(
              type: ouevre.oeuvreType,
              ouevre: ouevre,
            ).showBottonModalOptions(context);
        },
      ),
    );
  }

  Widget _showAllRating(OuevreEntity ouevre){
    if(cardSize == 220.0){
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 5.0,),
            Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(Icons.book, color: Colors.pinkAccent[400], size: 24.0,),
                      Icon(Icons.people, color: Colors.pinkAccent[400], size: 24.0,),
                      Icon(Icons.music_video, color: Colors.pinkAccent[400], size: 24.0,),
                      Icon(Icons.movie_filter, color: Colors.pinkAccent[400], size: 24.0,),
                      Icon(Icons.insert_emoticon, color: Colors.pinkAccent[400],size: 24.0,),
                    ],
                  ),
                  ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                   Text(ouevre.historyRate.toString(), style: styleAllRates),
                   Text(ouevre.characterRate.toString(), style: styleAllRates),
                   Text(ouevre.ostRate.toString(), style: styleAllRates),
                   Text(ouevre.effectsRate.toString(), style: styleAllRates),
                   Text(ouevre.enjoymentRate.toString(), style: styleAllRates),

                ],
              ),
            ),
            SizedBox(height: 5.0,),
            _buttonChangedRate(ouevre)      
          ],
        ),
      );
            
    }else{
      return Container();
    }
  }


  Widget _buttonChangedRate(OuevreEntity ouevre){
    if(cardSize == 220.0){
      return Container(
        child: FlatButton(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(width: 1.5, color: Colors.pinkAccent[400]) 
          ),
          child: Text('New Rate', style: styleAllRates,),
          onPressed: () {
            ButtomUpdateAndDelete(
              type: ouevre.oeuvreType,
              ouevre: ouevre,
            ).showBottonModalOptions(context);
          }
    ),
      );
    }else{
      return Container();
    }
    
  }

  double _getRatingActualFilter(OuevreEntity ouevre){
    switch (status) {
      
      case ListProfileQuery.Completed: return ouevre.finalRate;
        break;

      case ListProfileQuery.CompleteHistoryRate: return ouevre.historyRate;
        break;

      case ListProfileQuery.CompleteCharacterRate: return ouevre.characterRate;
        break;

      case ListProfileQuery.CompleteEffectsRate: return ouevre.effectsRate;
        break;

      case ListProfileQuery.CompleteOSTRate: return ouevre.ostRate;
        break;

      case ListProfileQuery.CompleteEnjoymentRate: return ouevre.enjoymentRate;
        break;

      case ListProfileQuery.CompleteOeuvreRating: return ouevre.oeuvreRating;
        break;          

      default: return ouevre.finalRate;
    }
  }

  void _changedSizedCard() {
    if(cardSize == 100.0){
      cardSize = 220.0;
      setState(() {});
    }else{
      cardSize = 100.0;
      setState(() {});
    }
  }
  Widget _changedIcon(){
    if(cardSize == 100.0){
      return Icon(Icons.keyboard_arrow_down, color: Colors.pinkAccent[400], size: 35.0,);
    }else{
      return Icon(Icons.keyboard_arrow_up, color: Colors.pinkAccent[400], size: 35.0,);
    }
  }
}
