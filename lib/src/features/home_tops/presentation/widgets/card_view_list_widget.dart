import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardViewListWidget extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context , i) => _buildCardItem(),
    );
  }

  Widget _buildCardItem() {
     return Container(
       child: _itemInfo(),
       height: 180.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey[800].withOpacity(0.4),
              Colors.blueGrey[700].withOpacity(0.5),
              Colors.blueGrey[600].withOpacity(0.7),
              Colors.blueGrey[500].withOpacity(0.9)
            ]
          ) 
        ),
     ); 
  }

  Widget _itemInfo() {
    return Row(
      children: <Widget>[
        _posterItem(),
      ],
    );

  }

  Widget _posterItem() {
    return Container(
      width: 120.0,
      height: 140.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: NetworkImage('https://image.tmdb.org/t/p/original/se86cWSwdSftjJH8OStW7Yu3ZPC.jpg'), //? Image Poster Item,
          placeholder: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQshqcXT2iUjDuVOWCIyEnY_yrAjXPCE0LpuBOjlhADKLBTdTFc'), //? PlaceHolder Item,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}