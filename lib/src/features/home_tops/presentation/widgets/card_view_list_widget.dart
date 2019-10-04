import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardViewListWidget extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context , i) => _buildCardItem(),
    );
  }

  Widget _buildCardItem() {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
       child: Container(
         child: _itemInfo(),
         height: 160.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              colors: [
                Colors.grey[400].withOpacity(0.1),
                Colors.grey[500].withOpacity(0.1),
                Colors.grey[600].withOpacity(0.1),
              ]
            ) 
          ),
       ),
     ); 
  }

  Widget _itemInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _posterItem(),
        SizedBox(width: 6.0,),
        Expanded(child: _columnCenterItem())
      ],
    );

  }

  Widget _columnCenterItem(){
    return Container(
      child: Column(
        children: <Widget>[
          _rowInfoItem(),
          //SizedBox(height: 10.0,),
          _chipGenresItem(),
          //SizedBox(height: 35.0,),
          _rowButtons(),
        ],
      ),
    );
  }

  //! Row  Info
  Widget _rowInfoItem(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        _titleItem(),
        _yearOfItem(),
        _rateItem()
        ],
      ),
    );
  }

  Widget _posterItem() {
    //! Agregar el Hero
    return Container(
      width: 110.0,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: NetworkImage('https://image.tmdb.org/t/p/original/se86cWSwdSftjJH8OStW7Yu3ZPC.jpg'), //? Image Poster Item,
          placeholder: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQshqcXT2iUjDuVOWCIyEnY_yrAjXPCE0LpuBOjlhADKLBTdTFc'), //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _titleItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 16.0),
      child: Text(
          'Peaky Blinders', 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),
          ),
    );
  }

  Widget _yearOfItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
          '2013', 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),   
        ),
    );
  }

  Widget _rateItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Row(
        children: <Widget>[
          Text('8.7', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Colors.orange[800]),),
          Icon(Icons.star, size: 20, color: Colors.orange[800], ) 
        ],
      ),
    );
  }

  //! Chip Genres
  // Widget _chipGenresItem() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: <Widget>[
  //       _fakeChip('drama', Colors.purple),
  //       _fakeChip('crime', Colors.redAccent),
  //       _fakeChip('action', Colors.blue),
  //     ],
  //   );
  // }

  Widget _chipGenresItem() {
    return SizedBox(
      height: 70.0,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _fakeChip('drama', Colors.grey[500].withOpacity(0.1)),
          _fakeChip('crime', Colors.grey[500].withOpacity(0.1)),
          _fakeChip('action', Colors.grey[500].withOpacity(0.1)),
        ],
      ),
    );
  }

  Widget _fakeChip(String text, Color color) {
    return Container(
      height: 25.0,
      width: 55.0,
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

  //! Actions Buttons

  // Widget _rowButtons() {
  //   return Container(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //        _buttonActions(Icons.check_circle, Colors.green), 
  //        _buttonActions(Icons.play_circle_filled, Colors.blue),
  //        _buttonActions(Icons.pause_circle_filled, Colors.orange),
  //        _buttonActions(Icons.remove_circle, Colors.red),
  //        _buttonActions(Icons.add_circle, Colors.purple),
  //       ],
  //     ),
  //   );
  // }

  //  Widget _rowButtons() {
  //   return Container(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //        _buttonActions(Icons.keyboard_arrow_down, Colors.white), 
         
  //       ],
  //     ),
  //   );
  // }


  Widget _rowButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
         _buttonActions(Icons.check_circle_outline, Colors.green), 
         _buttonActions(Icons.play_circle_outline, Colors.blue),
         _buttonActions(Icons.pause_circle_outline, Colors.orange),
         _buttonActions(Icons.remove_circle_outline, Colors.red),
         _buttonActions(Icons.add_circle_outline, Colors.purple),
        ],
      ),
    );
  }

  Widget _buttonActions(IconData icon, Color color){
    return IconButton(
      icon: Icon(
        icon, 
        size: 25.0, 
        color: color,
        ),
        onPressed: () {},
    );
  }
  
}