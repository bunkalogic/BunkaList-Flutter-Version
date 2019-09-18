import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class TopsScrollView extends StatelessWidget {



  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );
  

  @override
  Widget build(BuildContext context) {

  final _screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        height: _screenSize.height * 0.34,
        child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: 6,
          itemBuilder: (context, i) => _itemScroll(),
          //children: _cards(context),
        ),
      ),
    );

  
  }

  Widget _itemScroll() {
    return Container(
      margin: EdgeInsets.only(right: 5.0 ),
        child: Column(
          children: <Widget>[
            _itemImage(),
            SizedBox(height: 3.0,),
            _itemTitle(),
            _iconButton(),
          ],
        ),
    );
  }
  
  Widget _itemImage() {

    return Hero(
      tag: '',
      child: Card(
        borderOnForeground: false,
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage(
              //height: 130.0, // 125.0
              width: 155.0,  // 90.0
              image: NetworkImage('https://image.tmdb.org/t/p/original/hPPbYTXOOjHQ7OXXdFF6jPJwnmG.jpg'), //? Image Poster Item,
              placeholder: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQshqcXT2iUjDuVOWCIyEnY_yrAjXPCE0LpuBOjlhADKLBTdTFc'), //? PlaceHolder Item,
              fit: BoxFit.fill,
            ),
        ),
        ),
    );
  }

  Widget _itemTitle() {
    return Text(
          'Gintama',//? Title of Item
          style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        );
      
  }
  Widget _iconButton(){
    return PlatformIconButton(
          padding: EdgeInsets.all(1.0),
          iosIcon: Icon(CupertinoIcons.down_arrow, size: 25.0,),
          androidIcon: Icon(Icons.keyboard_arrow_down, size: 25.0,),
          onPressed: (){
            //! PushNamed Al ItemAllDetail
          },
        );
  }
}