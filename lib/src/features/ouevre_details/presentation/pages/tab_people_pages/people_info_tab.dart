import 'package:bunkalist/src/core/reusable_widgets/poster_column_widget.dart';
import 'package:flutter/material.dart';

class PeopleInfoTab extends StatelessWidget with PosterColumnWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _peopleImage(),
        _peopleName(),
        _peopleDate(),
        //_rowSocialMedia(),
        _cardInfoPeople(),
        _labelKnownFor(),
        _gridKnownFor(context)
      ],
    );
  }

  Widget _peopleImage() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://image.tmdb.org/t/p/w600_and_h900_bestv2/2RcaC1ictETsTU4ioFlQ32zGYYg.jpg'),
          radius: 60.0,
        ),
      ),
    );
  }

  Widget _peopleName() {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        'Damian Lewis',
        style: TextStyle(
          fontSize: 24.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w800
        ),
        textAlign: TextAlign.center,
        ),
    );
  }

  Widget _peopleDate() {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        'Birthday: 11-02-1971',
        style: TextStyle(
          fontSize: 18.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600
        ),
        textAlign: TextAlign.center,
        ),
    );
  }

  _rowSocialMedia() {
    //TODO: agregar los icons de fb, instagram y twitter
  }

  Widget _cardInfoPeople() {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: _columnBiography(),
    );
  }

  Widget _columnBiography() {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _labelBio(),
          _textBio()
        ],
      ),
    );
  }

  Widget _labelBio() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
            'Biography :',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600
            ),
          ),
    );
  }

  Widget _textBio() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0 ),
      child: Text(
        'Damian Watcyn Lewis (born 11 February 1971) is an English actor and producer. He is probably best known in the United States for starring as Detective Charlie Crews in the NBC drama Life as well as portraying Major Richard Winters in the HBO miniseries Band of Brothers.',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16.0),
        textAlign: TextAlign.justify,
        ),
    );
  }

  Widget _labelKnownFor() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
            'Known For :',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600
            ),
          ),
    );
  }

  Widget _gridKnownFor(BuildContext context){
    final double _aspectRatio = 2.5 / 4.1;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemBuilder: (context, i) => itemPoster(context),
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: _aspectRatio
          ),
        ),
      ),
    );
  }

  
}