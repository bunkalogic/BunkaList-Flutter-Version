import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridViewListWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, i) => _itemPoster(),
      itemCount: 24,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 3.8 / 4.8 ),
    );
  }

  Widget _itemPoster() {
    //! Agregar el Hero
    return GestureDetector(
        onTap: (){
          //! PushNamed Al ItemAllDetail
        },
        child: Container(
          padding: EdgeInsets.all(4.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: FadeInImage(
                  image: NetworkImage('https://image.tmdb.org/t/p/original/se86cWSwdSftjJH8OStW7Yu3ZPC.jpg'), //? Image Poster Item,
                  placeholder: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQshqcXT2iUjDuVOWCIyEnY_yrAjXPCE0LpuBOjlhADKLBTdTFc'), //? PlaceHolder Item,
                  fit: BoxFit.cover,
                ),
            ),
        ),
    );
  }


}