import 'package:flutter/material.dart';

class AllDetailsHeaderInfo extends StatelessWidget  {
  

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(    
      collapseMode: CollapseMode.parallax,
      background: _stackInfoBackground(),
      centerTitle: true,
      titlePadding: EdgeInsets.only(bottom: 60.0),
      title: _titleInfo(),
    );
  }

  Widget _titleInfo(){
    return Text(
        'Band of Brothers',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic
        ),
      );
  }

  

  _stackInfoBackground() {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          _imageBackground(),
          //_containerGradient(),
          _columnBackground(),
          //TODO: agregar los botones y el icono de la productora 
        ],
      ),
    );
  }

  Widget _containerGradient(){
    return SizedBox(
      height: 550.0,
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.clamp,
              begin: Alignment.center,
              end: Alignment.topCenter,
              colors: [
                //TODO que sea dependiendo del tema que esta selecionado
                Colors.grey[100].withOpacity(0.0),
                Colors.grey[100].withOpacity(0.5),
                Colors.grey[100].withOpacity(0.9),

              ]
            ),
          ),
      ),
    );
  }

  Widget _imageBackground() {
    return SizedBox(
      height: 250.0,
      width: double.infinity,
      child: Image.network(
         'https://image.tmdb.org/t/p/original/3BXWBm011oMqNniZX5BBymC5q5m.jpg',
         fit: BoxFit.cover,
        ),
    );

  }

  

  Widget _columnBackground() {
    return Container(
      alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _infoPoster(),
            _buttonAddInList(),
            _durationInfo(),
            SizedBox(height: 14.0,)
          ],
        ),
    ); 
  }

  Widget _buttonAddInList(){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlineButton(
          child: Text(
            'Add in your List',
            style: TextStyle(
              color: Colors.white,
              shadows: [Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))],
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          borderSide: BorderSide(width: 2.0, color: Colors.deepOrange),
          onPressed: (){},
      ),
    );
  }

  Widget _infoPoster() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
          width: 120.0,
          height: 120.0,
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: NetworkImage('https://image.tmdb.org/t/p/original/3XsoDoBvjhhHaT8O1JcxUfIwMu4.jpg'),
              placeholder: NetworkImage('https://image.tmdb.org/t/p/original/3XsoDoBvjhhHaT8O1JcxUfIwMu4.jpg'),
              fit: BoxFit.cover,
            ),
          ),
      ),
    );
  }


  Widget _durationInfo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _yearInfo(),
            SizedBox(width: 8.0),
            Icon(Icons.timer,color: Colors.purple[400], ),
            SizedBox(width: 2.0,),
            Text('60 min'),
          ],
        ),
      ),
    );
  }

  Widget _yearInfo() {
    return Text(
        '2001',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic
        ),
      );
  }
}