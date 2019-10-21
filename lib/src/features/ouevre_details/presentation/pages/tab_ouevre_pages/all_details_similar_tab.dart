import 'package:flutter/material.dart';

import 'package:bunkalist/src/core/reusable_widgets/poster_column_widget.dart';


class AllDetailsSimilarTab extends StatelessWidget with PosterColumnWidget {
  const AllDetailsSimilarTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final double _aspectRatioOriginal = 5.4 / 7.8;
    final double _aspectRatio = 2.5 / 4.1;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GridView.builder(
        itemBuilder: (context, i) => itemPoster(context),
        itemCount: 24,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: _aspectRatio
        ),
      ),
    );
  }
}