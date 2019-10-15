import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_yt_item_widget.dart';
import 'package:flutter/material.dart';

class AllDetailsOpenningTab extends StatelessWidget {
  const AllDetailsOpenningTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(5.0),
      itemCount: 10,
      itemBuilder: (context, i ) => AllDetailsYoutubeVideosItemWidget(),
    );
  }
}