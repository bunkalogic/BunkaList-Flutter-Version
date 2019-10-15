import 'package:flutter/material.dart';

class AllDetailsCastingTab extends StatelessWidget {
  const AllDetailsCastingTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _labelScrollPersonItem('Casting :'),
          _scrollPersonItem(),
          _labelScrollPersonItem('Crew :'),
          _scrollPersonItem()
        ],
      )
    );
  }

  Widget _labelScrollPersonItem(String label){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }

  Widget _scrollPersonItem(){
    return Container(
      height: 180.0,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        scrollDirection: Axis.horizontal,
        itemCount: 9,
        itemBuilder: (context, i)=> _personItem() ,
      ),
    );
  }

  Widget _personItem(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Column(
        children: <Widget>[
          _personPhotoItem(),
          _columnName(),
        ],
      ),
    );
  }

  Widget _personPhotoItem() {
    return Container(
      child: CircleAvatar(
        radius: 40.0,
        backgroundImage: NetworkImage('https://image.tmdb.org/t/p/w600_and_h900_bestv2/2RcaC1ictETsTU4ioFlQ32zGYYg.jpg'),
      ),
    );
  }

  Widget _columnName() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Damian Lewis', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),),
          Text('Richard D. Winters', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey[400]),),
          Text('10 Episodes', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.grey[300]),),
        ],
      ),
    );
  }
}