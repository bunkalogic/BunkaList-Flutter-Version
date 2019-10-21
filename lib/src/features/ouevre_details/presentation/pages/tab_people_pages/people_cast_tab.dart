import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PeopleCastTab extends StatelessWidget {
 

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
          _infoCharacter('Richard D. Winters'),
          _infoEpisodeCount(),
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
          image: NetworkImage('https://image.tmdb.org/t/p/original/kxpe2fkPIiUIB7y3j2cGe8SMN1D.jpg'), //? Image Poster Item,
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
          'Band of Brothers', 
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
          '2001', 
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
          Text('9.1', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Colors.orange[800]),),
          Icon(Icons.star, size: 20, color: Colors.orange[800], ) 
        ],
      ),
    );
  }

  Widget _infoCharacter(String character){
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        'Character: $character',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic
          ),
      ),
    );
  }

  Widget _infoEpisodeCount(){
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        'Episodes : 10 ',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic
          ),
      ),
    );
  }

  

  //! Actions Buttons

  

   Widget _rowButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
         _buttonActions(Icons.keyboard_arrow_down, Colors.purpleAccent[400]), 
         
        ],
      ),
    );
  }


  Widget _buttonActions(IconData icon, Color color){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: Icon(
          icon, 
          size: 35.0, 
          color: color,
          ),
          onPressed: () {},
      ),
    );
  }
  
}