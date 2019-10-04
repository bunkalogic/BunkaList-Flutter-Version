import 'package:flutter/material.dart';


class TabItemCompletedWidget extends StatefulWidget {
  const TabItemCompletedWidget({Key key}) : super(key: key);

  @override
  _TabItemCompletedWidgetState createState() => _TabItemCompletedWidgetState();
}

class _TabItemCompletedWidgetState extends State<TabItemCompletedWidget> {


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
           _showAllRating(),
           
         ],
        ),
      ),
    );
  }

  Widget _imageBackground() {
    return Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage(
            image: NetworkImage('https://image.tmdb.org/t/p/original/9gkG3bgwAguIjrUmjZxW5UaqKaC.jpg'),
            placeholder: NetworkImage('https://image.tmdb.org/t/p/original/9gkG3bgwAguIjrUmjZxW5UaqKaC.jpg', scale: 200 / 400 ),
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
    );

  }

  Widget _titleItem() {
    return Text(
      'John Wick 3 Parabellum',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
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
        Text('8.6', 
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
        icon: _changedIcon(),
        autofocus: true,
        onPressed: (){
          _changedSizedCard();
        },
      ),
    );
  }

  Widget _showAllRating(){
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
                      Icon(Icons.book, color: Colors.orange[900],           size: 28.0,),
                      Icon(Icons.people, color: Colors.orange[900], size: 28.0,),
                      Icon(Icons.music_video, color: Colors.orange[900],    size: 28.0,),
                      Icon(Icons.movie_filter, color: Colors.orange[900], size: 28.0,),
                      Icon(Icons.insert_emoticon, color: Colors.orange[900],size: 28.0,),
                    ],
                  ),
                  ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                   Text('7.0', style: styleAllRates),
                   Text('9.0', style: styleAllRates),
                   Text('8.5', style: styleAllRates),
                   Text('9.5', style: styleAllRates),
                   Text('8.0', style: styleAllRates),

                ],
              ),
            ),
            SizedBox(height: 5.0,),
            _buttonChangedRate()      
          ],
        ),
      );
            
    }else{
      return Container();
    }
  }


  Widget _buttonChangedRate(){
    if(cardSize == 220.0){
      return Container(
        child: FlatButton(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(width: 1.5, color: Colors.orange[900]) 
          ),
          child: Text('New Rate', style: styleAllRates,),
          onPressed: () {}
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
