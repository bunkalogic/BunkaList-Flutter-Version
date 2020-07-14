import 'package:flutter/material.dart';

class ToogleButtonsOrderByWidget extends StatefulWidget {
  ToogleButtonsOrderByWidget({Key key}) : super(key: key);

  @override
  _ToogleButtonsOrderByWidgetState createState() => _ToogleButtonsOrderByWidgetState();
}

class _ToogleButtonsOrderByWidgetState extends State<ToogleButtonsOrderByWidget> {

  List<bool> isSelected;

    @override
    void initState() {
        isSelected = [true, false];
        super.initState();
    }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        borderColor: Colors.deepPurpleAccent[400],
        fillColor: Colors.deepPurpleAccent,
        borderWidth: 2.0,
        selectedBorderColor: Colors.deepPurpleAccent[400],
        selectedColor: Colors.white,
        borderRadius: BorderRadius.circular(10.0),  
        children: [
          _toogleButton("Ascendente", Icons.arrow_upward),
          _toogleButton("Descendente", Icons.arrow_downward)
        ], 
        onPressed: (int index) {
          setState(() {
          for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
          }
          });
        },
        isSelected: isSelected,
      ),
    );
  }

  Widget _toogleButton(String title, IconData icon){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, size: 25.0,),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic
            ),
          ),
        ],
      ),
    );
  }
}