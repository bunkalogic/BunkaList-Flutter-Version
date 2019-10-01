import 'package:bunkalist/src/core/reusable_widgets/poster_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridViewListWidget extends StatelessWidget with PosterColumnWidget {


  @override
  Widget build(BuildContext context) {

    //final double _aspectRatioOriginal = 5.4 / 7.8;
    final double _aspectRatio = 2.0 / 3.6;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GridView.builder(
        itemBuilder: (context, i) => itemPoster(context),
        itemCount: 24,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: _aspectRatio
        ),
      ),
    );
  }


}