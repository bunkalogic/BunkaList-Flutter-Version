import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:bunkalist/src/widgets/bottom_sheet_add_your_list_widget.dart';



class TopsScrollView extends StatelessWidget {



  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );
  

  @override
  Widget build(BuildContext context) {

  final _screenSize = MediaQuery.of(context).size;

    return Container(
        height: 200.0,
        child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: 6,
          itemBuilder: (context, i) => _itemScroll(context),
        ),
    );

  
  }

  Widget _itemScroll(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _itemImage(), flex: 3,),
          _itemTitle(),
          Expanded(child: _iconButton(context), flex: 1,),
        ],
    );
  }


  
  Widget _itemImage() {

    return Hero(
      tag: '',
      child: GestureDetector(
        onTap: (){
          //! PushNamed Al ItemAllDetail
        },
        child: Card(
          margin: EdgeInsets.all(2.0),
          borderOnForeground: true,
          elevation: 5.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: FadeInImage(
                image: NetworkImage('https://image.tmdb.org/t/p/original/hPPbYTXOOjHQ7OXXdFF6jPJwnmG.jpg'), //? Image Poster Item,
                placeholder: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQshqcXT2iUjDuVOWCIyEnY_yrAjXPCE0LpuBOjlhADKLBTdTFc'), //? PlaceHolder Item,
                fit: BoxFit.contain,
              ),
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
  Widget _iconButton(BuildContext context){
    return PlatformIconButton(
          iosIcon: Icon(CupertinoIcons.down_arrow, size: 25.0,),
          androidIcon: Icon(Icons.keyboard_arrow_down, size: 25.0,),
          onPressed: (){
            BottomSheetAddInList().showButtomModalMaterial(context);
          },
        );
  }
}