import 'package:flutter/material.dart';

import 'package:bunkalist/src/core/reusable_widgets/poster_column_widget.dart';

class AllDetailsRecomendationTab extends StatelessWidget with PosterColumnWidget {
  const AllDetailsRecomendationTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _aspectRatio = 2.5 / 4.1;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GridView.builder(
        itemBuilder: (context, i) => CircularProgressIndicator(), //itemPoster(context),
        itemCount: 24,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: _aspectRatio
        ),
      ),
    );
  }
}