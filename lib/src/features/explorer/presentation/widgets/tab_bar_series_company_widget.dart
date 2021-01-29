import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/utils/get_list_company.dart';
import 'package:bunkalist/src/features/explorer/presentation/widgets/scroll_company_widget.dart';
import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class TabBarSeriesCompanyWidget extends StatefulWidget {
  TabBarSeriesCompanyWidget({Key key}) : super(key: key);

  @override
  _TabBarSeriesCompanyWidgetState createState() => _TabBarSeriesCompanyWidgetState();
}

class _TabBarSeriesCompanyWidgetState extends State<TabBarSeriesCompanyWidget> with SingleTickerProviderStateMixin{
  
  TabController _tabController;
  int _activeTabIndex;
  Preferences prefs = Preferences();

  bool isActiveTab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener(_setActiveTabIndex);
    
  }

  void _setActiveTabIndex() {
  _activeTabIndex = _tabController.index;

  isActiveTab = _activeTabIndex == 0;

  setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tabBar(),
        _buildBodyTab()
      ],
    );
  }


  Widget _tabBar() {
    return Container(
      height: 40.0,
      child: TabBar(
        isScrollable: true,
        tabs: [
          Tab(text: AppLocalizations.of(context).translate("label_serie_company_popular"),),
          Tab(text: AppLocalizations.of(context).translate("label_korean_serie_company"),),
          Tab(text: AppLocalizations.of(context).translate("label_japanese_serie_company"),),
        ],
        controller: _tabController,
        indicator: MD2Indicator(
          indicatorHeight: 3, 
          indicatorColor: prefs.whatModeIs ?  Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
          indicatorSize: MD2IndicatorSize.normal
        ),
      ),
    );
  }

  Widget _buildBodyTab(){
    return Container(
      height: 140.0,
      child: TabBarView(
        controller: _tabController,
        children: [
          ScrollCompanyWidget(companies: getListSeriesCompany(),),
          ScrollCompanyWidget(companies: getListKoreanSeriesCompany(),),
          ScrollCompanyWidget(companies: getListJapaneseSeriesCompany(),),
        ]
      ),
    );
  }
}