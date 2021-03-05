import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/utils/get_list_company.dart';
import 'package:bunkalist/src/core/utils/get_list_genres.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/entities/filter_entity.dart';
import 'package:flutter/material.dart';


class BuildFilterParamsWidget extends StatefulWidget {
  
  final Function(FilterParams) homeTops;
 

  BuildFilterParamsWidget({
    @required this.homeTops,
  });

  @override
  _BuildFilterParamsWidgetState createState() => _BuildFilterParamsWidgetState();
}

class _BuildFilterParamsWidgetState extends State<BuildFilterParamsWidget> {

   Preferences prefs = Preferences(); 
   final _titleController  = TextEditingController();

   FilterParams _newHomeTops;

  String _selectedType = '';
  String _selectedOrderBy = '';
  String _selectedGenre = '';
  String _selectedKeyword = '';
  String _selectedNetwork = '';
  String _selectedLanguage = '';
  int    _selectedYear = 0;
  bool _design = false;


  
  bool isTypeSelected = false;
  bool isOrderSelected = false;
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: _textEditAppBar(),
      body: _buildListBody(),
      floatingActionButton: _buildFabSaveChanged(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

  }

  Widget _textEditAppBar() {
    return AppBar(
      title: _buildTextEdit(),
      leading: AppBarButtonBack(),
      actions: [
        _buttonChangedDesign()
      ],
    );
  }

  Widget _buildTextEdit() {

    return TextFormField(
          controller: _titleController,
          maxLength: 40,
          decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate("label_title_select_home_tops"),
              labelStyle: TextStyle(color: Colors.grey[400])
          ),
        );

  }

  Widget _buttonChangedDesign() {
    return IconButton(
      icon: Icon(
        _design
          ? Icons.view_compact_rounded
          : Icons.view_carousel_rounded ,
        size: 32,
        color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
      ), 
      onPressed: (){
        _design = !_design;
        setState(() {});
      }
    );
  }

  Widget _buildListBody() {
    return ListView(
      children: [
        SizedBox(height: 25.0,),
        
        // select type
        BuildSelectChoiceType(
          listType: [
            AppLocalizations.of(context).translate("movies"),
            AppLocalizations.of(context).translate("series"),
            AppLocalizations.of(context).translate("animes"),
          ],
          typeSelected: (String type) {
            setState(() {
              _selectedType = type;
              
              isTypeSelected = !isTypeSelected;
            });
          },
        ),

        SizedBox(height: 25.0,),
        
        // select the order
        isTypeSelected 
          ? BuildSelectChoiceOrder(
            listOrderLabel: _getOrderFilter(_selectedType), 
            orderSelected: (String orderBy){

              setState(() {
                _selectedOrderBy = orderBy;

                isOrderSelected = !isOrderSelected;
              });

            }
          )
          : Container(),

        SizedBox(height: 25.0,),  

        // select the year (is optional)
       (isTypeSelected && isOrderSelected) 
        ? BuildSelectedYear(
          selectedYear: (int year){
            setState(() {
              _selectedYear = year;
            });
          },
        )
        : Container(),


        SizedBox(height: 25.0,), 

        
        // select genres (is optional) no limit

        (isTypeSelected && isOrderSelected)
          ? BuildSelectionChoiceGenres(
              title: AppLocalizations.of(context).translate("label_select_genres"),
              type: _selectedType, 
              genres: _getListGenres(), 
              selectedGenres: (String genres){
                setState(() {
                  _selectedGenre = genres;
                });
                
              },
              selectedGenresKeyword: (String genresKey){
                setState(() {
                  _selectedGenre = genresKey;
                });
              },
          )
          : Container(),

        SizedBox(height: 25.0,), 

        // select the Language (only if movie or tv) (is optional) limit only 1
        
        isTypeSelected && isOrderSelected && _selectedType != 'anime'
        ? BuildSelectionChoiceLanguage(
          selectedLanguage: (String language){
            setState(() {
              _selectedLanguage = language;
            });
          },
        )
        : Container(),

        SizedBox(height: 25.0,), 
        
        // select the network (only if tv or anime) (is optional) limit only 1
        
        (isTypeSelected && isOrderSelected && _selectedType != 'movie')
        ? BuildSelectionChoiceNetwork(
          title:  AppLocalizations.of(context).translate("label_select_network"),
          companies: _getNetwork(),
          selectedNetwork: (String network){
              setState(() {
                _selectedNetwork = network;
              });
          },
        )
        : Container(),

        

        
        
        SizedBox(height: 45.0,),

      ],
    );
  }



  Widget _buildFabSaveChanged() {

    return FloatingActionButton.extended(
      elevation: 10.0,
      backgroundColor: _getBackgroundColorTheme(),
      disabledElevation: 0,
      onPressed: !isTypeSelected && !isOrderSelected
      ? null
      : (){
        Navigator.of(context).pop();

        FilterParams homeTops = new FilterParams(
          title: _titleController.text,
          type: _selectedType,
          sortBy: _selectedOrderBy,
          withNetwork: _selectedNetwork,
          genre: _selectedGenre,
          withKeywords: _selectedKeyword,
          withOriginalLanguage: _selectedLanguage,
          year: _selectedYear,
          design: _design,
          voteCountGte: 0
        );


        setState(() {});

        widget.homeTops(homeTops);

      }, 
      label: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: Icon(
              Icons.save_rounded,
              color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
            ),
          ),
          Text(
            AppLocalizations.of(context).translate("btn_label_edit_save_top"),
            style: TextStyle(
              color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
              fontSize: 16.0,
              fontWeight: FontWeight.w700
            ),
          )
        ],
      ),
    );

  }


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

  // get order list filters

  List<Filters> _getOrderFilter(String type){

    List<Filters> filtersOrder = new List<Filters>();

    if(type == 'movie'){

      Filters filters1 = new Filters(
        label: AppLocalizations.of(context).translate("sort_popular"),
        value: ConstSortBy.popularityDesc
      );

      Filters filters2 = new Filters(
        label: AppLocalizations.of(context).translate("sort_date"),
        value: ConstSortBy.primaryReleaseDateAsc
      );

      Filters filters3 = new Filters(
        label: AppLocalizations.of(context).translate("sort_vote_count"),
        value: ConstSortBy.voteCountDesc
      );

      Filters filters4 = new Filters(
        label: AppLocalizations.of(context).translate("sort_vote_average"),
        value: ConstSortBy.voteAverageDesc
      );

      filtersOrder.add(filters1);
      filtersOrder.add(filters2);
      filtersOrder.add(filters3);
      filtersOrder.add(filters4);


    }else if(type == 'tv' || type == 'anime'){

      Filters filters1 = new Filters(
        label: AppLocalizations.of(context).translate("sort_popular"),
        value: ConstSortBy.popularityDesc
      );

      Filters filters2 = new Filters(
        label: AppLocalizations.of(context).translate("sort_date"),
        value: ConstSortBy.firstAirDateAsc
      );

      Filters filters3 = new Filters(
        label: AppLocalizations.of(context).translate("sort_vote_count"),
        value: ConstSortBy.voteCountDesc
      );

      Filters filters4 = new Filters(
        label: AppLocalizations.of(context).translate("sort_vote_average"),
        value: ConstSortBy.voteAverageDesc
      );

      filtersOrder.add(filters1);
      filtersOrder.add(filters2);
      filtersOrder.add(filters3);
      filtersOrder.add(filters4);

    }


    return filtersOrder;
  }

  List<Genres> _getListGenres(){

    switch (_selectedType) {
      case "movie": return getListGenresMovies(context);
        break;

      case "tv": return getListGenresSeries(context);
        break;

      case "anime": return getListGenresAnimes(context);
        break;  

      default: return getListGenresSeries(context);
    }

  }

  List<Company> _getNetwork(){

    List<Company> listNetwork = new List<Company>();

    if(_selectedType == 'tv'){

      List<Company> listNetPopular = getListSeriesCompany();

      List<Company> listNetJapanese = getListJapaneseSeriesCompany();

      List<Company> listNetKorean = getListKoreanSeriesCompany();


      listNetwork.addAll(listNetPopular);
      listNetwork.addAll(listNetJapanese);
      listNetwork.addAll(listNetKorean);

    }else if(_selectedType == 'anime'){

      listNetwork.addAll(getListAnimesCompany());

    }



    return listNetwork;

  }
  

}



class BuildSelectChoiceType extends StatefulWidget {

  final List<String> listType;

  final Function(String) typeSelected;

  BuildSelectChoiceType({
    @required this.listType,
    @required this.typeSelected
  });

  @override
  _BuildSelectChoiceTypeState createState() => _BuildSelectChoiceTypeState();
}

class _BuildSelectChoiceTypeState extends State<BuildSelectChoiceType> {
  
  Preferences prefs = Preferences();
  String selectedChoice = "";

  List<Widget> _buildChoiceList(){
    
    List<Widget> choices = List();

    widget.listType.forEach((label) {
      
      choices.add(
        ChoiceChip(
          label: Text(
            label, 
          ),
          labelStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600
          ),
          backgroundColor: Colors.blueGrey[500].withOpacity(0.3),
          selectedColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400], 
          selected: selectedChoice == label,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          elevation: 5.0,
          onSelected: (value) {
            setState(() {
              selectedChoice = label;

              int index = widget.listType.indexOf(label);

              String type = getValueType(index);

              widget.typeSelected(type);

            });
          },
        )
      );
    });

    return choices;
  }
  
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: 8.0,
      runSpacing: 8.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: _buildChoiceList()
    );
  }


  String getValueType(int index){
    switch (index) {
      
      case 0: return 'movie';
        break;
      
      case 1: return 'tv';
        break;
      
      case 2: return 'anime';
        break;    
      
      default: return 'tv';
    }
  }
}



class BuildSelectChoiceOrder extends StatefulWidget {
  
  final List<Filters> listOrderLabel;

  final Function(String) orderSelected;

  BuildSelectChoiceOrder({
    @required this.listOrderLabel,
    @required this.orderSelected
  });

  @override
  _BuildSelectChoiceOrderState createState() => _BuildSelectChoiceOrderState();
}

class _BuildSelectChoiceOrderState extends State<BuildSelectChoiceOrder> {
  

  Preferences prefs = Preferences();
  String selectedChoice = "";

  List<Widget> _buildChoiceList(){
    
    List<Widget> choices = List();

    widget.listOrderLabel.forEach((filter) {
      
      choices.add(
        ChoiceChip(
          label: Text(
            filter.label, 
          ),
          labelStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600
          ),
          backgroundColor: Colors.blueGrey[500].withOpacity(0.3),
          selectedColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400], 
          selected: selectedChoice == filter.label,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          elevation: 5.0,
          onSelected: (value) {
            setState(() {
              selectedChoice = filter.label;

              widget.orderSelected(filter.value);

            });
          },
        )
      );
    });

    return choices;
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _labelTitle(),
        _wrapChipOptions()
      ],
    );
  }

  Widget _labelTitle() {
    return Text(
      AppLocalizations.of(context).translate("order_by"),
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey
      ),
    );
  }

  _wrapChipOptions() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: 8.0,
      runSpacing: 8.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: _buildChoiceList(),
    );
  }
}




class BuildSelectionChoiceGenres extends StatefulWidget {

  final String title;
  final String type;
  final List<Genres> genres;
  final Function(String) selectedGenres;
  final Function(String) selectedGenresKeyword;

  BuildSelectionChoiceGenres({
    @required this.title,
    @required this.type,
    @required this.genres,
    @required this.selectedGenres,
    @required this.selectedGenresKeyword
  });

  @override
  _BuildSelectionChoiceGenresState createState() => _BuildSelectionChoiceGenresState();
}

class _BuildSelectionChoiceGenresState extends State<BuildSelectionChoiceGenres> {
  
  
  Preferences prefs = Preferences();
  
  List<String> selectGenre = new List<String>();
  List<String> selectKeyword = new List<String>();
  List<bool> listSelect = new List<bool>();

  @override
  void initState() { 
    super.initState();
    
    listSelect = _getListOfSelect();
  }


  List<Widget> _buildChoiceList(){
    
    List<Widget> choices = List();

    

    

    for (var i = 0; i < widget.genres.length; i++) {
      
      choices.add(
        FilterChip(
          label: Text(
            widget.genres[i].label, 
          ),
          labelStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600
          ),
          backgroundColor: Colors.blueGrey[500].withOpacity(0.3),
          selectedColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400], 
          selected: listSelect[i],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          elevation: 5.0,
          onSelected: (value) {
            setState(() {

              listSelect[i] = value;

              widget.genres[i].isKeyword 
                ? selectKeyword.add(widget.genres[i].id)
                : selectGenre.add(widget.genres[i].id);

                print(selectGenre.toString());

                String genres = selectGenre.join(",");
                String keyword = selectKeyword.join(",");

                widget.selectedGenres(genres);
                widget.selectedGenresKeyword(keyword);
            });
          },
        )
      );

    }

    return choices;
    
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _labelTitle(),
        _wrapChipOptions()
      ],
    );
  }

  Widget _labelTitle() {
    return Text(
      widget.title,
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey
      ),
    );
  }

  _wrapChipOptions() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: 8.0,
      runSpacing: 8.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: _buildChoiceList(),
    );
  }

  List<bool> _getListOfSelect(){
    
    List<bool> isSelectedMovies = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ];

    List<bool> isSelectedSeries = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ];

    List<bool> isSelectedAnimes = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ];

    switch (widget.type) {
      case 'movie': return  isSelectedMovies;
        break;

      case 'tv': return  isSelectedSeries;
        break;

      case 'anime': return  isSelectedAnimes;
        break;  

      default: return  isSelectedMovies;
    }


  }

}




class BuildSelectionChoiceNetwork extends StatefulWidget {
  
  final String title;
  final List<Company> companies;
  final Function(String) selectedNetwork;


  BuildSelectionChoiceNetwork({
    @required this.title,
    @required this.companies,
    @required this.selectedNetwork
  });

  @override
  _BuildSelectionChoiceNetworkState createState() => _BuildSelectionChoiceNetworkState();
}

class _BuildSelectionChoiceNetworkState extends State<BuildSelectionChoiceNetwork> {
  
  
  Preferences prefs = Preferences();
  String selectedChoice = "";

  List<Widget> _buildChoiceList(){
    
    List<Widget> choices = List();

    widget.companies.forEach((company) {
      
      choices.add(
        ChoiceChip(
          label: Text(
            company.label, 
          ),
          labelStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600
          ),
          backgroundColor: Colors.blueGrey[500].withOpacity(0.3),
          selectedColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400], 
          selected: selectedChoice == company.label,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          elevation: 5.0,
          onSelected: (value) {
            setState(() {
              selectedChoice = company.label;

              widget.selectedNetwork(company.id);

            });
          },
        )
      );
    });

    return choices;
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _labelTitle(),
        _wrapChipOptions()
      ],
    );
  }

  Widget _labelTitle() {
    return Text(
      widget.title,
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey
      ),
    );
  }

  _wrapChipOptions() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: 8.0,
      runSpacing: 8.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: _buildChoiceList(),
    );
  }
}



class BuildSelectionChoiceLanguage extends StatefulWidget {

  final Function(String) selectedLanguage;

  BuildSelectionChoiceLanguage({
    @required this.selectedLanguage
  });

  @override
  _BuildSelectionChoiceLanguageState createState() => _BuildSelectionChoiceLanguageState();
}

class _BuildSelectionChoiceLanguageState extends State<BuildSelectionChoiceLanguage> {
  Preferences prefs = Preferences();
  String selectedChoice = "";

  List<Filters> _listOfLanguage(){
    
    List<Filters> languages = new List<Filters>();


    final Filters english = new Filters(
      value: 'en',
      label: 'English'
    );

    final Filters spanish = new Filters(
      value: 'es',
      label: 'Spanish'
    );

    final Filters japanese = new Filters(
      value: 'ja',
      label: 'Japanese'
    );

    final Filters korean = new Filters(
      value: 'ko',
      label: 'Korean'
    );
    
    final Filters russian = new Filters(
      value: 'ru',
      label: 'Russian'
    );

    final Filters french = new Filters(
      value: 'fr',
      label: 'French'
    );

    final Filters german = new Filters(
      value: 'de',
      label: 'German'
    );

    final Filters italian = new Filters(
      value: 'it',
      label: 'Italian'
    );

    final Filters hindi = new Filters(
      value: 'hi',
      label: 'Hindi'
    );

    final Filters arabic = new Filters(
      value: 'ar',
      label: 'Arabic'
    );

    final Filters chinese = new Filters(
      value: 'zh',
      label: 'Chinese'
    );

    final Filters portuguese = new Filters(
      value: 'pt',
      label: 'Portuguese'
    );

    final Filters thai = new Filters(
      value: 'th',
      label: 'Thai',
    );

    languages.add(english);
    languages.add(spanish);
    languages.add(korean);
    languages.add(japanese);
    languages.add(french);
    languages.add(italian);
    languages.add(german);
    languages.add(chinese);
    languages.add(portuguese);
    languages.add(hindi);
    languages.add(arabic);
    languages.add(thai);
    languages.add(russian);

    return languages;

  }
  
  
  List<Widget> _buildChoiceList(){
    
    List<Widget> choices = List();

    List<Filters> languages = new List<Filters>();

    languages = _listOfLanguage();

    languages.forEach((language) {
      
      choices.add(
        ChoiceChip(
          label: Text(
            language.label, 
          ),
          labelStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600
          ),
          backgroundColor: Colors.blueGrey[500].withOpacity(0.3),
          selectedColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400], 
          selected: selectedChoice == language.label,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          elevation: 5.0,
          onSelected: (value) {
            setState(() {
              selectedChoice = language.label;

              widget.selectedLanguage(language.value);

            });
          },
        )
      );
    });

    return choices;
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _labelTitle(),
        _wrapChipOptions()
      ],
    );
  }

  Widget _labelTitle() {
    return Text(
      AppLocalizations.of(context).translate("label_select_idioma"),
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey
      ),
    );
  }

  _wrapChipOptions() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: 8.0,
      runSpacing: 8.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: _buildChoiceList(),
    );
  }
}




class BuildSelectedYear extends StatefulWidget {

  final Function(int) selectedYear;

  BuildSelectedYear({
    @required this.selectedYear
  });

  @override
  _BuildSelectedYearState createState() => _BuildSelectedYearState();
}

class _BuildSelectedYearState extends State<BuildSelectedYear> {
  
  Preferences prefs = Preferences();

  List<bool> isSelectedYear = [true, false];
  bool _selectedYear = false;

  int _finalSelectedYear = 0;

  double _sliderYear = 2000;

  

  
  @override
  Widget build(BuildContext context) {
    
   final toogleButtonsYear = Center(
          child: ToggleButtons(
            constraints: BoxConstraints(minHeight: 35.0),
            borderColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
            fillColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
            borderWidth: 2.0,
            selectedBorderColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
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
          inactiveColor: prefs.whatModeIs ? Colors.pinkAccent[100] : Colors.deepPurpleAccent[100],
          activeColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
          label: '${_sliderYear.toInt()}',
          value: _sliderYear, 
          onChanged: (newValue){
          setState(() {
            _sliderYear = newValue;
            _finalSelectedYear = _sliderYear.toInt();

            widget.selectedYear(_finalSelectedYear);
                
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
          SizedBox(height: 25,),
          _selectedYear ? _labelYearSelected() : Container(),
          _selectedYear ? sliderYear : Container(),
        ],
      );
    }

    Widget _labelYearSelected(){

      return Center(
        child: Text(
          '$_finalSelectedYear',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
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
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic
            ),
          ),
        ],
      ),
    );
  }
  
}



class Filters{

  final String label;
  final String value;

  Filters({
    this.label,
    this.value
  });

}


