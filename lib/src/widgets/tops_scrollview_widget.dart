import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class TopsScrollView extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _scrollBuilder(),
    );
  }

  Widget _scrollBuilder() {
      //return BlocBuilder<MyBloc, MyState>(
        //builder: (context, state) {
          //return _itemScroll();
        //},
      //);

  }

  Widget _itemScroll() {
    final item = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          _itemTitle(),
          SizedBox(height: 2.0,),
          _itemImage(),
          _iconButton(),
          
        ],
      )
    );

    return item;
  }
  
  Widget _itemImage() {

    return Hero(
      tag: '',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage(
          height: 105.0,
          width: 80.0,
          image: NetworkImage('https://image.tmdb.org/t/p/original/wjFU9z8EfOwczRTv0FrPcv9zHME.jpg'), //? Image Poster Item,
          placeholder: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQshqcXT2iUjDuVOWCIyEnY_yrAjXPCE0LpuBOjlhADKLBTdTFc'), //? PlaceHolder Item,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _itemTitle() {
    return Text(
          'Cowboy Bebop',//? Title of Item
          style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        );
      
  }
  Widget _iconButton(){
    return PlatformIconButton(
          iosIcon: Icon(CupertinoIcons.down_arrow, size: 25.0,),
          androidIcon: Icon(Icons.keyboard_arrow_down, size: 25.0,),
          padding: EdgeInsets.all(10.0),
          onPressed: (){
            //! PushNamed Al ItemAllDetail
          },
        );
  }
}