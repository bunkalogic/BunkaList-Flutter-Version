import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';





class BuildBottomModalFilter extends StatefulWidget {
  final String type;

  BuildBottomModalFilter({this.type});

  @override
  _BuildBottomModalFilterState createState() => _BuildBottomModalFilterState();
}

class _BuildBottomModalFilterState extends State<BuildBottomModalFilter> {
  
  FilterOptions finalFilterOptions = new FilterOptions();

  String radioButtonGruop = '';

  List<bool> isSelected = [true, false];
  bool _selected = false;

  List<bool> isSelectedYear = [true, false];
  bool _selectedYear = false;

  int _finalSelectedYear = 0;

  double _sliderYear = 2000;

  

  
  List<String> listMoviesSortAsc = [
    ConstSortBy.popularityAsc,
    ConstSortBy.voteAverageAsc,
    ConstSortBy.voteCountAsc,
    ConstSortBy.releaseDateAsc
  ]; 

  List<String> listMoviesSortDesc = [
    ConstSortBy.popularityDesc,
    ConstSortBy.voteAverageDesc,
    ConstSortBy.voteCountDesc,
    ConstSortBy.releaseDateDesc
  ]; 

  List<String> listSeriesOrAnimeSortAsc = [
    ConstSortBy.popularityAsc,
    ConstSortBy.voteAverageAsc,
    ConstSortBy.voteCountAsc,
    ConstSortBy.firstAirDateAsc
  ]; 

  List<String> listSeriesOrAnimeSortDesc = [
    ConstSortBy.popularityDesc,
    ConstSortBy.voteAverageDesc,
    ConstSortBy.voteCountDesc,
    ConstSortBy.firstAirDateDesc
  ];

  String _getListValuesSortBy(int index){
    switch(widget.type){
        
        case 'movies' : {
         
         return _selected 
         ? listMoviesSortDesc[index] 
         : listMoviesSortAsc[index];

        }
        break;

        case 'tv'     : {
          return _selected 
          ? listSeriesOrAnimeSortDesc[index] 
          : listSeriesOrAnimeSortAsc[index];
        }
        break;

        case 'animes' : {
          return _selected 
          ? listSeriesOrAnimeSortDesc[index] 
          : listSeriesOrAnimeSortAsc[index];
        }
        break;

        default: return '';

    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8.0),
      // height: MediaQuery.of(context).size.height * 0.95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children:[ 
          _labelFilterYear(),
          _toogleButtonsYear(),
          SizedBox(height: 12.0,),
          _labelFilterOptions(),
         _toogleButtonsOrder(),
          _listRadioButtons(),
          _rowTopActions(),
          SizedBox(height: 12.0,),
        ]  
      ),
    );
  }

  Widget _rowTopActions() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 15.0,),
            Expanded(
              flex: 1,
              child: RaisedButton(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Text(
                  AppLocalizations.of(context).translate('accept'),
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                ),
                color: Colors.pinkAccent[400],
                onPressed: (){
                  finalFilterOptions = new FilterOptions(
                    sortBy: radioButtonGruop,
                    year: _finalSelectedYear
                  );

                  Navigator.pop(context, finalFilterOptions);
                }
              ),
            ),
            SizedBox(width: 20.0,),
            Expanded(
              flex: 1,
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(
                    color: Colors.pinkAccent[400]
                  )
                ),
                child: Text(
                  AppLocalizations.of(context).translate('cancel'),
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                ),
                color: Colors.pinkAccent[400],
                onPressed: (){
                  Navigator.pop(context,);
                }
              ),
            ),
            SizedBox(width: 15.0,),
          ],
        ),
      ),
    );
  }

  Widget _labelFilterOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          AppLocalizations.of(context).translate('order_by'),
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic
          ),
        ),
      ),
    );
  }

  Widget _toogleButtonsOrder(){
     return Center(
      child: ToggleButtons(
        constraints: BoxConstraints(minHeight: 35.0),
        borderColor: Colors.pinkAccent[400],
        fillColor: Colors.pinkAccent[400],
        borderWidth: 2.0,
        selectedBorderColor: Colors.pinkAccent[400],
        selectedColor: Colors.white,
        borderRadius: BorderRadius.circular(10.0),  
        children: [
          _toogleButton(
            AppLocalizations.of(context).translate('label_asc'), 
            Icons.arrow_upward),
          _toogleButton(
            AppLocalizations.of(context).translate('label_desc'),
             Icons.arrow_downward)
        ], 
        onPressed: (int index) {
          setState(() {
          for (int i = 0; i < isSelected.length; i++) {
             _selected = isSelected[i] = i == index;
               
          }
          });
        },
        isSelected: isSelected,
      ),
    );
  }

  Widget _toogleButton(String title, IconData icon){
    return Container(
      width: (MediaQuery.of(context).size.width - 150)/2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, size: 18.0,),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic
            ),
          ),
        ],
      ),
    );
  }

  Widget _listRadioButtons() {
   return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(),
          RadioListTile<String>(    
          dense: true,  
          value: _getListValuesSortBy(0), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.pinkAccent[400],
          title: Text(
            AppLocalizations.of(context).translate('sort_popular'),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
        Divider(),
        RadioListTile<String>(
          dense: true,
          value: _getListValuesSortBy(1), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.pinkAccent[400],
          title: Text(
            AppLocalizations.of(context).translate('sort_vote_average'),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
        Divider(),
        RadioListTile<String>(
          dense: true,
          value: _getListValuesSortBy(2), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.pinkAccent[400],
          title: Text(
            AppLocalizations.of(context).translate('sort_vote_count'),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
        Divider(),
        RadioListTile<String>(
          dense: true,
          value: _getListValuesSortBy(3), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.pinkAccent[400],
          title: Text(
            AppLocalizations.of(context).translate('sort_date'),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
        Divider(),    
        ],
      );
  }

  Widget _labelFilterYear() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          AppLocalizations.of(context).translate('label_year'),
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic
          ),
        ),
      ),
    );
  }

  Widget _toogleButtonsYear(){
   final toogleButtonsYear = Center(
          child: ToggleButtons(
            constraints: BoxConstraints(minHeight: 35.0),
            borderColor: Colors.pinkAccent[400],
            fillColor: Colors.pinkAccent[400],
            borderWidth: 2.0,
            selectedBorderColor: Colors.pinkAccent[400],
            selectedColor: Colors.white,
            borderRadius: BorderRadius.circular(10.0),  
            children: [
              _toogleButton(
                AppLocalizations.of(context).translate('label_anyone'), 
                Icons.calendar_today),
              _toogleButton(
                AppLocalizations.of(context).translate('label_one_year'), 
                Icons.today)
            ], 
            onPressed: (int index) {
              setState(() {
              
              for (int i = 0; i < isSelectedYear.length; i++) {
                 _selectedYear = isSelectedYear[i] = i == index;

                _finalSelectedYear = !_selectedYear ? 0 : _finalSelectedYear;
                print(_finalSelectedYear);
              }
              });
            },
            isSelected: isSelectedYear,
          ),
        );

      

      final sliderYear = Container(
        padding: EdgeInsets.all(8.0),
        child: Slider(
          inactiveColor: Colors.pinkAccent[100],
          activeColor: Colors.pinkAccent[400],
          label: '${_sliderYear.toInt()}',
          value: _sliderYear, 
          onChanged: (newValue){
          setState(() {
            _sliderYear = newValue;
            _finalSelectedYear = _sliderYear.toInt();
          });

          
          },
          min: 1921,
          max: 2021,
          divisions: 100,
        ),
      );  

      return Column(
        children: [
          toogleButtonsYear,
          _selectedYear ? sliderYear : Container(),
        ],
      );
    }
  }




class FilterOptions{
  final String sortBy;
  final int year;
  final voteCount;

  FilterOptions({this.sortBy, this.year, this.voteCount});
}