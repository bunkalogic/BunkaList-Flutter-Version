import 'package:bunkalist/src/core/reusable_widgets/bottom_sheet_add_your_list_widget.dart';
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
          Expanded(child: _itemImage(), flex: 4,),
          _itemTitle(),
          Expanded(child: _iconButton(context), flex: 1,),
        ],
    );
  }


  
  Widget _itemImage() {

    //! Agregar el Hero

    return GestureDetector(
        onTap: (){
          //! PushNamed Al ItemAllDetail
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
            BottomSheetAddInList().showButtomModalMaterial(context);
          },
        );
  }
}


