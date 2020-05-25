import 'dart:async';

import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';


class NoAdsPage extends StatefulWidget {

  @override
  _NoAdsPageState createState() => _NoAdsPageState();
}

class _NoAdsPageState extends State<NoAdsPage> {

   StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  StreamSubscription _conectionSubscription;
  final List<String> _productLists = [
    'remove_ads_and_premium',
    'no_ads_yearly',
    'no_ads_1_month'
  ];
  String _platformVersion = 'Unknown';
  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];    
  

   @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    if (_conectionSubscription != null) {
      _conectionSubscription.cancel();
      _conectionSubscription = null;
    }
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterInappPurchase.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // prepare
    var result = await FlutterInappPurchase.instance.initConnection;
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAllItems;
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _conectionSubscription = FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      print('purchase-updated: $productItem');
    });

    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });
  }

   void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  Future _getProduct() async {
    List<IAPItem> items = await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in items) {
      print('${item.toString()}');
      // if(item.productId == widget.productId){
      //}
      
    }

    setState(() {
      this._items = items;
      this._purchases = [];
    });
  }

  void _requestSubscription(IAPItem item) {
    FlutterInappPurchase.instance.requestSubscription(item.productId);
  }

  Future _getSubscriptions(int position) async {
    List<IAPItem> items = await FlutterInappPurchase.instance.getSubscriptions(_productLists);
    for (var item in items) {
      
      if(item.productId == _productLists[position]){
        print('${item.toString()}');
        this._items.add(item);
      }
      
    }

    setState(() {
      this._items = items;
      this._purchases = [];
    });
  }

  Future _getPurchases(int position) async {
    List<PurchasedItem> items =
        await FlutterInappPurchase.instance.getAvailablePurchases();
    for (var item in items) {
      
      if(item.productId == _productLists[position]){
        print('${item.toString()}');
        this._purchases.add(item);
      }
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }

   List<Widget> _renderPurchases() {
    List<Widget> widgets = this
        ._purchases
        .map((item) => Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList();
    return widgets;
  }

  List<Widget> _renderInApps() {
    List<Widget> widgets = this
        ._items
        .map((item) => Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    FlatButton(
                      color: Colors.orange,
                      onPressed: () {
                        print("---------- Buy Item Button Pressed");
                        this._requestPurchase(item);
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 48.0,
                              alignment: Alignment(-1.0, 0.0),
                              child: Text('Buy Item'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("label_ads")),
          leading: AppBarButtonBack(),
        ),
      body: ListView(
      children: <Widget>[
        _labelRemoveAds(),
        _containerOneMouthNoAds(),
        _containerOneYearNoAds(),
        _containerLifetimeNoAds(),
        _labelCancelSubscription(),
        _labelCommingPremium(),
        // Column(
        //   children: this._renderInApps(),
        // ),
        // Column(
        //   children: this._renderPurchases(),
        // ),
      ],
    ),
    );
  }

  Widget _labelRemoveAds() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          AppLocalizations.of(context).translate("label_remove_ads"),
          textAlign:TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            fontSize: 22.0
          ),
        ),
      ),
    );
  }

  Widget _containerOneMouthNoAds() {
    return Padding(
      padding: EdgeInsets.symmetric( 
        horizontal: 60.0, 
        vertical: 15.0
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blueGrey[400],
        ),
        child: ListTile(
          leading: Icon(Icons.exposure_plus_1, color: Colors.yellowAccent, size: 25.0,),
          title: Text(
             AppLocalizations.of(context).translate("label_month_ads"),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              shadows: [
               Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
              ]
            ),
          ),
          //subtitle: Text('Cancel subscription any time in Google Play.'),
          onTap: () async {
            print("---------- Connect Billing in process");
            await FlutterInappPurchase.instance.initConnection;

            print("---------- Get Sub Month in process");
            this._getSubscriptions(2);

            this._items.map((item) {
              this._requestSubscription(item);
            } );

            print("---------- Get Purchases Button Pressed");
            this._getPurchases(2); 
           
            print("---------- Buy Item in process");
            this._items.map((item) {
              this._requestPurchase(item);
            } );

            
                        
          },
        ),
      ), 
    );
  }

  Widget _containerOneYearNoAds() {
    return Padding(
      padding: EdgeInsets.symmetric( 
        horizontal: 40.0, 
        vertical: 15.0
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.tealAccent[400],
        ),
        child: ListTile(
          leading: Icon(Icons.local_offer, color: Colors.deepOrangeAccent[400], size: 30.0,),
          title: Text(
            AppLocalizations.of(context).translate("label_year_ads"),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              shadows: [
               Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
              ]
            ),
          ),
          onTap: () async {
            print("---------- Connect Billing Button Pressed");
            await FlutterInappPurchase.instance.initConnection;

            this._items.map((item) {
              this._requestSubscription(item);
            } );


            print("---------- Get Sub Month Button Pressed");
            this._getSubscriptions(1);

            print("---------- Buy Item in process");
            this._items.map((item) {
              this._requestPurchase(item);
            } );

            // print("---------- Get Purchases Button Pressed");
            // this._getPurchases(1);
          },
        ),
      ), 
    );
  }

  Widget _containerLifetimeNoAds() {
    return Padding(
      padding: EdgeInsets.symmetric( 
        horizontal: 20.0, 
        vertical: 15.0
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent[400],
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: ListTile(
          leading: Icon(Icons.local_play, color: Colors.redAccent[400], size: 35.0,),
          title: Text(
            AppLocalizations.of(context).translate("label_never_ads"),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              shadows: [
               Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
              ]
            ),
          ),
          subtitle: Text(
            AppLocalizations.of(context).translate("label_never_ads_with_premium"),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              shadows: [
               Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
              ]
            ),
            ),
          onTap: (){
            //AppPurchasePage(productId: 'remove_ads_and_premium',);
          },
        ),
      ), 
    );
  }

  Widget _labelCancelSubscription() {
    return Text(
      AppLocalizations.of(context).translate("label_subscription"),
      textAlign:TextAlign.center,
    );
  }

   Widget _labelCommingPremium() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
         AppLocalizations.of(context).translate("label_include_premium"),
        textAlign:TextAlign.center,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}




class AppPurchasePage extends StatefulWidget {

  // final String productId;    
  // final String subscriptionId;

  // AppPurchasePage({this.productId, this.subscriptionId});

  @override
  _AppPurchasePageState createState() => _AppPurchasePageState();
}

class _AppPurchasePageState extends State<AppPurchasePage> {
  

  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  StreamSubscription _conectionSubscription;
  final List<String> _productLists = [
    'remove_ads_and_premium',
    'no_ads_yearly',
    'no_ads_1_month'
  ];
  String _platformVersion = 'Unknown';
  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];    
  

   @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    if (_conectionSubscription != null) {
      _conectionSubscription.cancel();
      _conectionSubscription = null;
    }
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterInappPurchase.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // prepare
    var result = await FlutterInappPurchase.instance.initConnection;
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAllItems;
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _conectionSubscription = FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      print('purchase-updated: $productItem');
    });

    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });
  }

   void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  Future _getProduct() async {
    List<IAPItem> items = await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in items) {
      print('${item.toString()}');
      // if(item.productId == widget.productId){
      //}
      
    }

    setState(() {
      this._items = items;
      this._purchases = [];
    });
  }

  void _requestSubscription(IAPItem item) {
    FlutterInappPurchase.instance.requestSubscription(item.productId);
  }

  Future _getSubscriptions() async {
    List<IAPItem> items = await FlutterInappPurchase.instance.getSubscriptions(_productLists);
    for (var item in items) {
      print('${item.toString()}');
      //if(item.productId == widget.subscriptionId){
        this._items.add(item);
      //}
      
    }

    setState(() {
      this._items = items;
      this._purchases = [];
    });
  }

  Future _getPurchases() async {
    List<PurchasedItem> items =
        await FlutterInappPurchase.instance.getAvailablePurchases();
    for (var item in items) {
      print('${item.toString()}');
      this._purchases.add(item);
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }

  Future _getPurchaseHistory() async {
    List<PurchasedItem> items = await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in items) {
      print('${item.toString()}');
      this._purchases.add(item);
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }
  

   List<Widget> _renderInApps() {
    List<Widget> widgets = this
        ._items
        .map((item) => Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    FlatButton(
                      color: Colors.orange,
                      onPressed: () {
                        print("---------- Buy Item Button Pressed");
                        this._requestPurchase(item);
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 48.0,
                              alignment: Alignment(-1.0, 0.0),
                              child: Text('Buy Item'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
    return widgets;
  }

  List<Widget> _renderPurchases() {
    List<Widget> widgets = this
        ._purchases
        .map((item) => Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList();
    return widgets;
  }
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width-20;
    double buttonWidth=(screenWidth/3)-20;

    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'Running on: $_platformVersion\n',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: buttonWidth,
                        height: 60.0,
                        margin: EdgeInsets.all(7.0),
                        child: FlatButton(
                          color: Colors.amber,
                          padding: EdgeInsets.all(0.0),
                          onPressed: () async {
                            print("---------- Connect Billing Button Pressed");
                            await FlutterInappPurchase.instance.initConnection;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: Alignment(0.0, 0.0),
                            child: Text(
                              'Connect Billing',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: buttonWidth,
                        height: 60.0,
                        margin: EdgeInsets.all(7.0),
                        child: FlatButton(
                          color: Colors.amber,
                          padding: EdgeInsets.all(0.0),
                          onPressed: () async {
                            print("---------- End Connection Button Pressed");
                            await FlutterInappPurchase.instance.endConnection;
                            if (_purchaseUpdatedSubscription != null) {
                              _purchaseUpdatedSubscription.cancel();
                              _purchaseUpdatedSubscription = null;
                            }
                            if (_purchaseErrorSubscription != null) {
                              _purchaseErrorSubscription.cancel();
                              _purchaseErrorSubscription = null;
                            }
                            setState(() {
                              this._items = [];
                              this._purchases = [];
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: Alignment(0.0, 0.0),
                            child: Text(
                              'End Connection',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            width: buttonWidth,
                            height: 60.0,
                            margin: EdgeInsets.all(7.0),
                            child: FlatButton(
                              color: Colors.green,
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                print("---------- Get Items Button Pressed");
                                this._getProduct();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                alignment: Alignment(0.0, 0.0),
                                child: Text(
                                  'Get Items',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            )),
                        Container(
                            width: buttonWidth,
                            height: 60.0,
                            margin: EdgeInsets.all(7.0),
                            child: FlatButton(
                              color: Colors.green,
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                print(
                                    "---------- Get Purchases Button Pressed");
                                this._getPurchases();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                alignment: Alignment(0.0, 0.0),
                                child: Text(
                                  'Get Purchases',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            )),
                        Container(
                            width: buttonWidth,
                            height: 60.0,
                            margin: EdgeInsets.all(7.0),
                            child: FlatButton(
                              color: Colors.green,
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                print(
                                    "---------- Get Purchase History Button Pressed");
                                this._getPurchaseHistory();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                alignment: Alignment(0.0, 0.0),
                                child: Text(
                                  'Get Purchase History',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            )),
                      ]),
                ],
              ),
              Column(
                children: this._renderInApps(),
              ),
              Column(
                children: this._renderPurchases(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}