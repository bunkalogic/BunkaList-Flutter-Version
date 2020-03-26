import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/update_and_delete_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class TabItemCompletedWidget extends StatefulWidget {

  

  final String type; 
  final String status;

  const TabItemCompletedWidget({
    @required this.type,
    @required this.status
  });

  @override
  _TabItemCompletedWidgetState createState() => _TabItemCompletedWidgetState();
}

class _TabItemCompletedWidgetState extends State<TabItemCompletedWidget> {

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetListsBloc>(context)..add(
      GetYourLists( type: widget.type, status: widget.status)
    );
  }

  
  final loadingPage = Center(
      child: CircularProgressIndicator(),
    ) ;

  double cardSize = 120.0;

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
          
          return loadingPage;

        }else if(state is GetListsLoaded){

          return Container(
      child: ListView.builder(
        itemCount: state.ouevreList.length,
        itemBuilder: (context, i) => _itemTab(state.ouevreList[i])
        ),
    );

        }else if(state is GetlistsError){
          
          return Center(
            child: Text('something Error'),
          );

        }

        return Center(
          child: Text('something Error'),
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
          
          Navigator.pushNamed(
              context, '/AllDetails', 
              arguments: 
              getIdAndType(
                ouevre.oeuvreId, 
                ouevre.oeuvreType,  
                ouevre.oeuvreTitle)
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
             _buttomExtend(),
             _showAllRating(ouevre),
             
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.stars, color: Colors.deepOrange,),
        Text(ouevre.finalRate.toString(), 
        style: TextStyle(
          fontSize: 18.0, 
          fontWeight: FontWeight.w900, 
          color: Colors.deepOrange,
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
        Icon(Icons.today, color: Colors.deepOrange,),
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

  Widget _buttomExtend() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: IconButton(
        icon: _changedIcon(),
        autofocus: true,
        onPressed: (){
          _changedSizedCard();
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
            Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(Icons.book, color: Colors.orange[900], size: 28.0,),
                      Icon(Icons.people, color: Colors.orange[900], size: 28.0,),
                      Icon(Icons.music_video, color: Colors.orange[900], size: 28.0,),
                      Icon(Icons.movie_filter, color: Colors.orange[900], size: 28.0,),
                      Icon(Icons.insert_emoticon, color: Colors.orange[900],size: 28.0,),
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
            side: BorderSide(width: 1.5, color: Colors.orange[900]) 
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

  void _changedSizedCard() {
    if(cardSize == 120.0){
      cardSize = 220.0;
      setState(() {});
    }else{
      cardSize = 120.0;
      setState(() {});
    }
  }
  Widget _changedIcon(){
    if(cardSize == 120.0){
      return Icon(Icons.keyboard_arrow_down, color: Colors.purple[400], size: 35.0,);
    }else{
      return Icon(Icons.keyboard_arrow_up, color: Colors.purple[400], size: 35.0,);
    }
  }
}
