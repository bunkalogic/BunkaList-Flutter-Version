import 'package:flutter/material.dart';

class AllDetailsInfoTab extends StatelessWidget {
  const AllDetailsInfoTab({Key key}) : super(key: key);

  



  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 0),
      children: <Widget>[
        _boxInfo(child: _columnInfo()),
        _boxInfo(child: _columnExtrasInfo()),
      ],
    );
  }

  Widget _boxInfo({Widget child}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      elevation: 5.0,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: child,
    );
  }

  //! ColumnInfo

  Widget _columnInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _rowRatingAndNetwork(),
          _overviewInfo(),
          _chipGenresItem()
        ],
      ),
    );
  }

  Widget _rowRatingAndNetwork() {
    final _ratingStyle = new TextStyle(
      color: Colors.deepOrange,
      fontSize: 20.0,
      fontWeight: FontWeight.w700
    );

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(Icons.people, color: Colors.grey[400], size: 25.0, ),
          Text('2343'),
          Spacer(),
          Icon(Icons.stars, color: Colors.deepOrange, size: 25.0,),
          Text('9.37', style: _ratingStyle,),
          Spacer(),
          Icon(Icons.business, color: Colors.grey[400], size: 25.0, ),
          Image.network('https://image.tmdb.org/t/p/h50_filter(negate,000,666)/tuomPhY2UtuPTqqFnKMVHvSb724.png', height: 15.0,)
        ],
      ),
    );
  }

  Widget _overviewInfo() {
    final _overviewStyle = new TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 14.0
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Text("Ea tempor labore consequat ipsum commodo ex magna officia dolor. Do labore velit reprehenderit consectetur non quis laboris ipsum fugiat minim Lorem sit tempor. Veniam consequat duis commodo nulla cupidatat veniam excepteur culpa dolore. Cillum enim ea id non ipsum aute duis laboris occaecat. Qui quis labore dolore labore dolore laboris. Magna culpa deserunt culpa fugiat occaecat do nisi id anim dolor aliquip irure incididunt. Anim ipsum occaecat eu consectetur sunt nostrud aliquip fugiat tempor." + 
          "Do eiusmod cupidatat aliquip laboris ullamco duis do fugiat eu veniam eu velit excepteur consectetur. Minim sit veniam minim exercitation officia labore ad aute quis. Sunt qui amet mollit qui reprehenderit dolore fugiat consequat ex incididunt pariatur elit incididunt esse. Laborum deserunt sunt amet nisi pariatur in duis consectetur sit. Magna exercitation fugiat sit in excepteur cupidatat duis amet laborum. Sint cillum pariatur exercitation sit sint fugiat irure.",
        style: _overviewStyle,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _chipGenresItem() {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _fakeChip('Drama', Colors.grey[500].withOpacity(0.2)),
          _fakeChip('Action', Colors.grey[500].withOpacity(0.2)),
          _fakeChip('War & Politics', Colors.grey[500].withOpacity(0.2)),
        ],
      ),
    );
  }

  Widget _fakeChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0 ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0)
      ), 
      child: Text(
        text, 
        textAlign: TextAlign.center, 
        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600), ),
    );
  }

  //! ColumnInfoExtras

  Widget _columnExtrasInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _labelExtraInfo('More Info', 22.0, FontWeight.w600),
          SizedBox(height: 10.0,),
          _rowLabelExtraInfo('Original Title:', 'Number of Season:'),
          _rowDataExtraInfo("Band of Brothers", '1'),
          SizedBox(height: 10.0,),
          _rowLabelExtraInfo('Release Date:', 'last episode aired:'),
          _rowDataExtraInfo("09/09/2001", '04/11/2001'),
          SizedBox(height: 10.0,),
          _rowLabelExtraInfo('Original language: ', 'Origin Country:'),
          _rowDataExtraInfo("English", 'United States'),
          SizedBox(height: 10.0,),
          _rowWebExtraInfo()

        ],
      ),
    );
  }

  Widget _labelExtraInfo(String text, double size, FontWeight fontWeight) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: Text(text,
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.justify,
      ),
    ); 
  }

  Widget _rowLabelExtraInfo(String label1, String label2){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _labelExtraInfo(label1, 16.0, FontWeight.w600),
          _labelExtraInfo(label2, 16.0, FontWeight.w600)
        ],
      ),
    );
  }

  Widget _rowDataExtraInfo(String label1, String label2){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        
        children: <Widget>[
          _labelExtraInfo(label1, 14.0, FontWeight.w500),
          _labelExtraInfo(label2, 14.0, FontWeight.w500), 
        ],
      ),
    );
  }

  Widget _rowWebExtraInfo(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _labelExtraInfo('Web :', 18.0, FontWeight.w800),
          Text(
            'https://es.hboespana.com/',
            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 16.0),
          )
        ],
      ),
    );
  }

}



