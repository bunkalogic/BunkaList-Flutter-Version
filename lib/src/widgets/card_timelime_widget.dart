import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CardTimelineWidget extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(1.0),
      child:Container(
        child: Column(
          children: <Widget>[
            _rowInformationUserItem(),
            SizedBox(height: 5.0,),
            _rowInfoOeuvre(),
            SizedBox(height: 5.0,),
            _rowButtonOptions(),
          ],
        ),
      ),
    );
  }

  //! Widget about user info

  Widget _rowInformationUserItem(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _userNameAndImageProfile(),
        _dateInfo()
      ],
    );
  }

  Widget _userNameAndImageProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //TODO: referctor of widget in this 
        Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 24.0,
            backgroundImage: NetworkImage('https://avatarfiles.alphacoders.com/187/187187.png'),
          ),
        ),
        Text('Username', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),)
      ],
    );
  }

  Widget _dateInfo(){
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Text('Hace 9 horas', style: TextStyle(fontSize: 12.0)),
    );
  }


 //! Widget about oeuvre info


  Widget _rowInfoOeuvre() {
    return Row(
      children: <Widget>[
        _imageAndName(),
        SizedBox(width: 2.0,),
        _comment()
      ],
    );
  }

  Widget _imageAndName() {
    return Column(
      children: <Widget>[
        _imageOuevre(),
        SizedBox(height: 4.0,),
        _titleOuevre(),
        SizedBox(height: 4.0,),
        _seasonAndEpisodeInfo(),
      ],
    );

  }

  Widget _imageOuevre() {
     return Padding(
       padding: EdgeInsets.only(left: 5.0),
       child: SizedBox(
         height: 120.0,
         width: 80.0,
         child: ClipRRect(
           borderRadius: BorderRadius.circular(5.0),
           child: FadeInImage(
             fit: BoxFit.cover,
             image: NetworkImage('https://image.tmdb.org/t/p/original/4jgfq2SP66rXBZ6AFFKEJ7M93aP.jpg'),
             placeholder: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQshqcXT2iUjDuVOWCIyEnY_yrAjXPCE0LpuBOjlhADKLBTdTFc'),
           ),
         ),
       ),
     );
  }

  Widget _titleOuevre() {
    return Padding(
      padding: EdgeInsets.only(left: 5.0),
      child: Text(
        'Game of Thrones',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          
          ),
          
      ),
    );
  }

  Widget _seasonAndEpisodeInfo() {
    return Column(
      children: <Widget>[
        Text(
          'season: 4',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic ),
        ),
      ],
    );
  }

  Widget _comment() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Text(
          'Non esse minim nisi irure minim officia labore exercitation ad Lorem pariatur in. Ipsum est amet eu nulla sunt velit. Culpa consequat eu adipisicing minim aute. Enim velit sunt aliquip est est non est ex.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _rowButtonOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buttonChatComment(),
        _buttonFav()
      ],
    );
  }

  Widget _buttonChatComment() {
    return IconButton(
      icon: Icon(Icons.chat, color: Colors.orange[700], size: 26.0,),
      onPressed: (){},
    );
  }

  Widget _buttonFav() {
    return IconButton(
      icon: Icon(Icons.favorite_border, color: Colors.red[700], size: 26.0,),
      onPressed: (){

      },
    );
  }
}