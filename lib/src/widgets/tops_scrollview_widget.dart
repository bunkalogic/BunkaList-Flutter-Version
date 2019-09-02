import 'dart:collection';

import 'package:flutter/widgets.dart';


class TopsScrollView extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _scrollBuilder(),
    );
  }

  Widget _scrollBuilder() {
      return BlocBuilder<MyBloc, MyState>(
        builder: (context, state) {
          return _itemScroll();
        },
      );
  }

  Widget _itemScroll() {
    final item = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          _itemImage(),
          // TODO: Agregar el espacio entre el titulo y el poster 
        ],
      ),
    );

    return item;
  }

  Widget _itemImage() {

    return Hero(
      tag: '',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          height: 40.0,
          width: 40.0,
          image: NetworkImage(''), //? Image Poster Item,
          placeholder: AssetImage(''), //? PlaceHolder Item,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}