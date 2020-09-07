import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class BottomModalFilter {

  final String type;

  BottomModalFilter({this.type});

  FilterOptions finalFilterOptions = new FilterOptions();

  String radioButtonGruop = '';

  List<bool> isSelected = [true, false];
  bool _selected = false;
  int _selectedYearIndex = 0;

  int _finalSelectedYear = -1;

  bool _selectedYear = false;

  List<int> listOfYear = [
    1900,
    1901,
    1902,
    1903,
    1904,
    1905,
    1906,
    1907,
    1908,
    1909,
    1910,
    1911,
    1912,
    1913,
    1914,
    1915,
    1916,
    1917,
    1918,
    1919,
    1920,
    1921,
    1922,
    1923,
    1924,
    1925,
    1926,
    1927,
    1928,
    1929,
    1930,
    1931,
    1932,
    1933,
    1934,
    1935,
    1936,
    1937,
    1938,
    1939,
    1940,
    1941,
    1942,
    1943,
    1944,
    1945,
    1946,
    1947,
    1948,
    1949,
    1950,
    1951,
    1952,
    1953,
    1954,
    1955,
    1956,
    1957,
    1958,
    1959,
    1960,
    1961,
    1962,
    1963,
    1964,
    1965,
    1966,
    1967,
    1968,
    1969,
    1970,
    1971,
    1972,
    1973,
    1974,
    1975,
    1976,
    1977,
    1978,
    1979,
    1980,
    1981,
    1982,
    1983,
    1984,
    1985,
    1986,
    1987,
    1988,
    1989,
    1990,
    1991,
    1992,
    1993,
    1994,
    1995,
    1996,
    1997,
    1998,
    1999,
    2000,
    2001,
    2002,
    2003,
    2004,
    2005,
    2006,
    2007,
    2008,
    2009,
    2010,
    2011,
    2012,
    2013,
    2014,
    2015,
    2016,
    2017,
    2018,
    2019,
    2020
  ];

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
    switch(type){
        
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

  //  showBottonModalFilter(BuildContext context){
  //   showModalBottomSheet<FilterOptions>(
  //     isScrollControlled: true,
  //     elevation: 10.0,
  //     isDismissible: false,
  //     backgroundColor: _getBackgroundColorTheme(), 
  //     context: context,
  //     builder: (context) => buildBottomModal(context,),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: const Radius.circular(30),
  //         topRight: const Radius.circular(30)
  //       )
  //     )
  //   );

    
  // }

  Color _getBackgroundColorTheme() {
    final prefs = new Preferences();

    if(prefs.whatModeIs && prefs.whatDarkIs == false){
      return Colors.blueGrey[900];
    }else if(prefs.whatModeIs && prefs.whatDarkIs == true){
      return Colors.grey[900];
    }
    else{
      return Colors.grey[100];
    }
  }

  Widget buildBottomModal() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter state) {
        // Build the layout
        return Container(
      padding: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.95,
      child: Column(
        children:[ 
          _labelFilterYear(),
          _toogleButtonsYear(),
          //carrouselOfYear(context),
          _labelFilterOptions(),
         _toogleButtonsOrder(),
          _listRadioButtons(),
          Spacer(),
          _rowTopActions(context),
        ]  
      ),
    );
      }
    );
    
  }

  Widget _rowTopActions(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                color: Colors.deepPurpleAccent[400],
                onPressed: (){
                  finalFilterOptions = new FilterOptions(
                    sortBy: radioButtonGruop,
                    year: _finalSelectedYear
                  );

                  Navigator.pop(context, finalFilterOptions);
                }
              ),
            ),
            SizedBox(width: 10.0,),
            Expanded(
              flex: 1,
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(
                    color: Colors.deepPurpleAccent[400]
                  )
                ),
                child: Text(
                  AppLocalizations.of(context).translate('cancel'),
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                ),
                color: Colors.deepPurpleAccent[400],
                onPressed: (){
                  Navigator.pop(context,);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _labelFilterOptions() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Order by",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic
          ),
        ),
      ),
    );
  }

  Widget _toogleButtonsOrder(){
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
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
             _selected = isSelected[i] = i == index;
               
          }
          });
        },
        isSelected: isSelected,
      ),
    );
      }
    );
  }

  Widget _toogleButton(String title, IconData icon){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, size: 25.0,),
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
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
      
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(),
          RadioListTile<String>(  
          value: _getListValuesSortBy(0), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.deepPurpleAccent[400],
          title: Text(
            'Por Popularidad',
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
          value: _getListValuesSortBy(1), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.deepPurpleAccent[400],
          title: Text(
            'Por Media de Votos',
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
          value: _getListValuesSortBy(2), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.deepPurpleAccent[400],
          title: Text(
            'Por Numeros de votos',
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
          value: _getListValuesSortBy(3), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.deepPurpleAccent[400],
          title: Text(
            'Por Fecha de Salida',
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
    );
  }

  Widget _labelFilterYear() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Year",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic
          ),
        ),
      ),
    );
  }

  Widget _toogleButtonsYear(){
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){

        final toogleButtonsYear = Center(
          child: ToggleButtons(
            borderColor: Colors.deepPurpleAccent[400],
            fillColor: Colors.deepPurpleAccent,
            borderWidth: 2.0,
            selectedBorderColor: Colors.deepPurpleAccent[400],
            selectedColor: Colors.white,
            borderRadius: BorderRadius.circular(10.0),  
            children: [
              _toogleButton("Cualquiera", Icons.calendar_today),
              _toogleButton("Un Año", Icons.today)
            ], 
            onPressed: (int index) {
              setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                 _selectedYear = isSelected[i] = i == index;

                _finalSelectedYear = !_selectedYear ? -1 : _finalSelectedYear;
                print(_finalSelectedYear);
              }
              });
            },
            isSelected: isSelected,
          ),
        );

       final carouselYear = Container(
        padding: EdgeInsets.all(8.0),
        child: CarouselSlider.builder(
          enlargeCenterPage: true, 
          height: MediaQuery.of(context).size.height / 12.0,
          autoPlay: false,
          viewportFraction: 0.36,
          itemCount: listOfYear.length,
          onPageChanged: (int i){
            setState((){
              _selectedYearIndex = i;

              _finalSelectedYear = listOfYear[i];
              print(_finalSelectedYear);
            });

          },
          itemBuilder: (context, i) => Text(
            listOfYear[i].toString(),
            style: TextStyle(
              fontSize: _selectedYearIndex == i ? 22.0 : 20.0,
              fontWeight: _selectedYearIndex == i ? FontWeight.w900 : FontWeight.w400,
              fontStyle: _selectedYearIndex == i ? FontStyle.italic: FontStyle.normal,
            ),
          ),
        ),
      );

      return Column(
        children: [
          toogleButtonsYear,
          _selectedYear ? carouselYear : Container(),
        ],
      );
    }
    );
  }
  
}


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

  int _selectedYearIndex = 0;

  int _finalSelectedYear = -1;

  double _sliderYear = 2000;

  

  List<int> listOfYear = [
    1900,
    1901,
    1902,
    1903,
    1904,
    1905,
    1906,
    1907,
    1908,
    1909,
    1910,
    1911,
    1912,
    1913,
    1914,
    1915,
    1916,
    1917,
    1918,
    1919,
    1920,
    1921,
    1922,
    1923,
    1924,
    1925,
    1926,
    1927,
    1928,
    1929,
    1930,
    1931,
    1932,
    1933,
    1934,
    1935,
    1936,
    1937,
    1938,
    1939,
    1940,
    1941,
    1942,
    1943,
    1944,
    1945,
    1946,
    1947,
    1948,
    1949,
    1950,
    1951,
    1952,
    1953,
    1954,
    1955,
    1956,
    1957,
    1958,
    1959,
    1960,
    1961,
    1962,
    1963,
    1964,
    1965,
    1966,
    1967,
    1968,
    1969,
    1970,
    1971,
    1972,
    1973,
    1974,
    1975,
    1976,
    1977,
    1978,
    1979,
    1980,
    1981,
    1982,
    1983,
    1984,
    1985,
    1986,
    1987,
    1988,
    1989,
    1990,
    1991,
    1992,
    1993,
    1994,
    1995,
    1996,
    1997,
    1998,
    1999,
    2000,
    2001,
    2002,
    2003,
    2004,
    2005,
    2006,
    2007,
    2008,
    2009,
    2010,
    2011,
    2012,
    2013,
    2014,
    2015,
    2016,
    2017,
    2018,
    2019,
    2020
  ];

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
          //carrouselOfYear(context),
          _labelFilterOptions(),
         _toogleButtonsOrder(),
          _listRadioButtons(),
          // Spacer(),
          _rowTopActions(),
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
                color: Colors.deepPurpleAccent[400],
                onPressed: (){
                  finalFilterOptions = new FilterOptions(
                    sortBy: radioButtonGruop,
                    year: _finalSelectedYear
                  );

                  Navigator.pop(context, finalFilterOptions);
                }
              ),
            ),
            SizedBox(width: 10.0,),
            Expanded(
              flex: 1,
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(
                    color: Colors.deepPurpleAccent[400]
                  )
                ),
                child: Text(
                  AppLocalizations.of(context).translate('cancel'),
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                ),
                color: Colors.deepPurpleAccent[400],
                onPressed: (){
                  Navigator.pop(context,);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _labelFilterOptions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
        constraints: BoxConstraints(minHeight: 40.0),
        borderColor: Colors.deepPurpleAccent[400],
        fillColor: Colors.deepPurpleAccent[400],
        borderWidth: 2.0,
        selectedBorderColor: Colors.deepPurpleAccent[400],
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
          value: _getListValuesSortBy(0), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.deepPurpleAccent[400],
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
          value: _getListValuesSortBy(1), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.deepPurpleAccent[400],
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
          value: _getListValuesSortBy(2), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.deepPurpleAccent[400],
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
          value: _getListValuesSortBy(3), 
          groupValue: radioButtonGruop, 
          onChanged: (String value){
              setState((){

                radioButtonGruop = value;
                print(radioButtonGruop);
              });
            },
          activeColor: Colors.deepPurpleAccent[400],
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
      padding: const EdgeInsets.all(8.0),
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
            constraints: BoxConstraints(minHeight: 40.0),
            borderColor: Colors.deepPurpleAccent[400],
            fillColor: Colors.deepPurpleAccent[400],
            borderWidth: 2.0,
            selectedBorderColor: Colors.deepPurpleAccent[400],
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
              // for (int i = 0; i < isSelectedYear.length; i++) {
              //    _selectedYear = isSelectedYear[i] = i == index;

              //   _finalSelectedYear = !_selectedYear ? -1 : _finalSelectedYear;
              //   print(_finalSelectedYear);
              // }
              for (int i = 0; i < isSelectedYear.length; i++) {
                 _selectedYear = isSelectedYear[i] = i == index;

                _finalSelectedYear = !_selectedYear ? -1 : _finalSelectedYear;
                print(_finalSelectedYear);
              }
              });
            },
            isSelected: isSelectedYear,
          ),
        );

      //  final carouselYear = Container(
      //   padding: EdgeInsets.all(8.0),
      //   child: CarouselSlider.builder(
      //     enlargeCenterPage: true, 
      //     height: MediaQuery.of(context).size.height / 12.0,
      //     autoPlay: false,
      //     viewportFraction: 0.36,
      //     initialPage: 100,
      //     itemCount: listOfYear.length,
      //     onPageChanged: (int i){
      //       setState((){
      //         _selectedYearIndex = i;

      //         _finalSelectedYear = listOfYear[i];
      //         print(_finalSelectedYear);
      //       });

      //     },
      //     itemBuilder: (context, i) => Text(
      //       listOfYear[i].toString(),
      //       style: TextStyle(
      //         fontSize: _selectedYearIndex == i ? 22.0 : 20.0,
      //         fontWeight: _selectedYearIndex == i ? FontWeight.w900 : FontWeight.w400,
      //         fontStyle: _selectedYearIndex == i ? FontStyle.italic: FontStyle.normal,
      //       ),
      //     ),
      //   ),
      // );

      final sliderYear = Container(
        padding: EdgeInsets.all(8.0),
        child: Slider(
          inactiveColor: Colors.deepPurpleAccent[100],
          activeColor: Colors.deepPurpleAccent[400],
          label: '${_sliderYear.toInt()}',
          value: _sliderYear, 
          onChanged: (newValue){
          setState(() {
            _sliderYear = newValue;
            _finalSelectedYear = _sliderYear.toInt();
          });

          
          },
          min: 1920,
          max: 2020,
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