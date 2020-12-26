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
      height: 40.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.genres.length,
        itemBuilder: (context, i) =>  _chipsGenres(widget.genres[i])
      ),
    );
  }

  Widget _chipsGenres(Genres genres){

      return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      child: ActionChip(
          onPressed: () {
             Navigator.pushNamed(context, '/ExplorerGenre', arguments: genres);
          },
          elevation: 4.0,
          labelPadding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
          backgroundColor: Colors.blueGrey[500].withOpacity(0.2),
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