import 'package:bunkalist/src/core/reusable_widgets/poster_column_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';





class TopsScrollView extends StatelessWidget with PosterColumnWidget {



  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );
  

  @override
  Widget build(BuildContext context) {

    return Container(
        height: 200.0,
        child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: 6,
          itemBuilder: (context, i) => itemPoster(context),
        ),
    );

  
  }

}  