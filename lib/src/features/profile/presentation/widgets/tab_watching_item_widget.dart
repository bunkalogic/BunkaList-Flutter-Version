import 'package:flutter/material.dart';


class TabItemWatchingWidget extends StatefulWidget {
  const TabItemWatchingWidget({Key key}) : super(key: key);

  @override
  _TabItemWatchingWidgetState createState() => _TabItemWatchingWidgetState();
}

class _TabItemWatchingWidgetState extends State<TabItemWatchingWidget> {


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
    return _itemTab();
  }

  Widget _itemTab() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      curve: Curves.decelerate,
      height: cardSize,
      child: GestureDetector(
        onTap: (){
          //TODO: implementar pushNamed al AllDetails
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
             _imageBackground(),
             _gradientBackground(),
             _listTileInfoItem(),
             _buttomExtend(),
             
           ],
          ),
        ),
      ),
    );
  }

  Widget _imageBackground() {
    return Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage(
            image: NetworkImage('https://image.tmdb.org/t/p/original/A30ZqEoDbchvE7mCZcSp6TEwB1Q.jpg'),
            placeholder: NetworkImage('https://image.tmdb.org/t/p/original/A30ZqEoDbchvE7mCZcSp6TEwB1Q.jpg', scale: 200 / 400 ),
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

  Widget _listTileInfoItem(){
    return ListTile(
      leading: _itemRate(),
      title: _titleItem(),
      trailing: _itemDate(),
      subtitle: _rowInfoSeasonAndEpisode(),
      
    );

  }

  Widget _titleItem() {
    return Text(
      'Vikings',
      textAlign: TextAlign.center,
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

  Widget _itemRate() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.stars, color: Colors.deepOrange,),
        Text('No rate', 
        style: TextStyle(
          fontSize: 14.0, 
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

  Widget _itemDate() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.today, color: Colors.deepOrange,),
        Text('22/07/19', 
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
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.purple[400], size: 35.0,),
        onPressed: (){
          //TODO: Dialog para cambiar el Status
        },
      ),
    );
  }

  _rowInfoSeasonAndEpisode(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _subTitleSeasonInfo(),
        _threeTitleEpisodeInfo()
      ],
    );
  }

  Widget _subTitleSeasonInfo() {
    return Text(
      'Season: 3',
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

  Widget _threeTitleEpisodeInfo() {
    return Text(
      'Episode: 11',
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
