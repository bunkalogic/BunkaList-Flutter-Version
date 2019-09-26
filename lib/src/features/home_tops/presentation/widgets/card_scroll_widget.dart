import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class CardScrollWidget extends StatelessWidget {
  
  

  @override
  Widget build(BuildContext context) {

    //? variables
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemHeight: _screenSize.width * 0.6,
        itemWidth: _screenSize.height * 0.4,
        viewportFraction: 0.8,
        scale: 0.9,

        itemBuilder: (BuildContext context, int index){

          //! Agregar el Hero
          // TODO: Agregar el id de el elemento + -card

          return ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: GestureDetector(
                onTap: () {},
                child: FadeInImage(
                  image: NetworkImage('https://image.tmdb.org/t/p/original/lfTur3Wdh4kiUbKF6rkm9XuVuG.jpg'),
                  placeholder: NetworkImage('https://image.tmdb.org/t/p/original/lfTur3Wdh4kiUbKF6rkm9XuVuG.jpg', scale: 10.0),
                  fit: BoxFit.fill,
                ),
              ),
          );
        },
        itemCount: 6,
      ),
    );
  }
}