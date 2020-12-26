import 'dart:ui';

import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/item_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';


class TopDetailPage extends StatefulWidget {

  final List<OuevreEntity> ouevreList;

  TopDetailPage({@required this.ouevreList});

  @override
  _TopDetailPageState createState() => _TopDetailPageState();
}

class _TopDetailPageState extends State<TopDetailPage> {
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Tu Top Series Favoritas'),
          leading: AppBarButtonBack(),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {

    final List<String> titles = new List<String>();
    final List<Widget> images = new List<Widget>();
    

    widget.ouevreList.forEach((element) {
      int position = element.positionListFav;



      String title = "$position. ${element.oeuvreTitle}";

      titles.add(title);
      images.add(_itemImage(element.oeuvrePoster, position));
    });


    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: VerticalCardPager(
                titles: titles, 
                images: images,
                initialPage: 0,
                onSelectedItem: (index) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                      elevation: 5,
                      backgroundColor: Colors.transparent,
                      child: BuildItemDetailsWidget(ouevreEntity: widget.ouevreList[index]),
                      );
                    },
                  ); 
                },
                textStyle: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 2.5,
                    )
                  ]
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _itemImage(String pathImage, int position){

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage(pathImage);

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            placeholder: placeholder, 
            image: poster,
            fit: BoxFit.cover,
            ),
        ),
      ),
    );
  }
}
