import 'package:bunkalist/src/core/theme/get_background_color.dart';
import 'package:bunkalist/src/core/utils/get_list_genres.dart';
import 'package:flutter/material.dart';


class ScrollRowGenres extends StatefulWidget {
  final List<Genres> genres;
  ScrollRowGenres({this.genres});

  @override
  _ScrollRowGenresState createState() => _ScrollRowGenresState();
}

class _ScrollRowGenresState extends State<ScrollRowGenres> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.genres.length,
        itemBuilder: (context, i) =>  _chipsGenres(widget.genres[i])
      ),
    );
  }

  Widget _chipsGenres(Genres genres){

      return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      child: ActionChip(
          onPressed: () {
             Navigator.pushNamed(context, '/ExplorerGenre', arguments: genres);
          },
          elevation: 4.0,
          labelPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          backgroundColor: getBackgroundColorItemTheme(),
          label: Text(genres.label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
      );
  } 
}