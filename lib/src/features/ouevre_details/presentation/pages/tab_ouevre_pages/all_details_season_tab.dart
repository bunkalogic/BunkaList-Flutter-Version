import 'package:flutter/material.dart';

class AllDetailsSeasonTab extends StatelessWidget {
  const AllDetailsSeasonTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, i) => _itemSeason(context),
    );
  }

  Widget _itemSeason(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: _rowSeasonInfo(context),
      ),
    );
  }

  Widget _rowSeasonInfo(BuildContext context) {
    return Row(
      children: <Widget>[
        _imageSeasonItem(),
        _columnSeasonTextInfo(),
        _buttomDetailsSeason(context)
      ],
    );
  }

  Widget _imageSeasonItem() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 8.0),
        child: SizedBox(
          width: 90.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage('https://image.tmdb.org/t/p/original/kxpe2fkPIiUIB7y3j2cGe8SMN1D.jpg'),
          ),
        ),
      ),
    );
  }

  Widget _columnSeasonTextInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _titleSeasonItem(),
          _numberEpisodeSeasonItem(),
          _releaseDateSeasonItem()

        ],
      ),
    );
  }


  Widget _titleSeasonItem() {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          'Season 1',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic
          ),
        ),
    );
  }

  Widget _numberEpisodeSeasonItem() {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          '10 Episodes',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
    );
  }

  Widget _releaseDateSeasonItem() {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          '9 September 2001',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
    );
  }

  Widget _buttomDetailsSeason(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.chevron_right, size: 40.0, color: Colors.deepOrange,),
      onPressed: (){
        Navigator.pushNamed(context, '/AllDetailsSeason', arguments: 1);
      },
    );
  }

  
}