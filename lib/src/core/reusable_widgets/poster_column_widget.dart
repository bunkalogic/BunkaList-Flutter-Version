import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';



abstract class PosterColumnWidget{

  Widget itemPoster(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _itemImageAndRating(context), flex: 4,),
          _itemTitle(),
          Expanded(child: _iconButton(context), flex: 1,),
        ],
    );
  }

  Widget _itemImageAndRating(BuildContext context){
    return Container(
      child: Stack(
        children: <Widget>[
          _itemImage(context),
          _itemRating()
        ],
      ),
    );
  }

  Widget _itemRating(){
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[400].withOpacity(0.4)
      ),
      child: Text(
        '8.3',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          shadows: [
           Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(0.8, 0.8))
          ]
          ),
      ),
    );
  }

  
  Widget _itemImage(BuildContext context) {

    //! Agregar el Hero

    return GestureDetector(
        onTap: (){
          //! PushNamed Al ItemAllDetail
          Navigator.pushNamed(context, '/AllDetails', arguments: 1);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage(
            image: NetworkImage('https://image.tmdb.org/t/p/original/osV1XMpOHpf1NEygfoqZZPdPgQ9.jpg'), //? Image Poster Item,
            placeholder: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQshqcXT2iUjDuVOWCIyEnY_yrAjXPCE0LpuBOjlhADKLBTdTFc'), //? PlaceHolder Item,
            fit: BoxFit.cover,
          ),
        ),
    );
  }

  Widget _itemTitle() {
    return Text(
          'John Wick 3',//? Title of Item
          style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        );
      
  }

  Widget _iconButton(BuildContext context){
    return PlatformIconButton(
          iosIcon: Icon(CupertinoIcons.down_arrow, size: 25.0,),
          androidIcon: Icon(Icons.keyboard_arrow_down, size: 25.0,),
          onPressed: (){
            //BottomSheetAddInList().showButtomModalMaterial(context);
          },
        );
  }

}


