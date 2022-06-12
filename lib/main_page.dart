import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'page_info.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin, RouteAware {
  final GlobalKey<ScaffoldState> _navigatorKey = GlobalKey();
  int _selectedIndex = 0;
  late List<PageInfo> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = <PageInfo>[
      HomePage(
        analytics: widget.analytics,
        observer: widget.observer,
      ),
      ProfilePage(
        analytics: widget.analytics,
        observer: widget.observer,
      ),
    ];

    // // if (kIsWeb) {
    // //   if (Platform.isAndroid) {
    //     _showAndroidDownload(context);
    //   // } else if (Platform.isIOS) {
    //   //   _showiOSDownload(context);
    //   // }
    // // }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.observer.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    widget.observer.unsubscribe(this);
    super.dispose();
  }

  Future<void> _logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _sendAnalyticsEvent(int counter) async {
    await widget.analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'counter': counter,
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        // Only strings and numbers (ints & doubles) are supported for GA custom event parameters:
        // https://developers.google.com/analytics/devguides/collection/analyticsjs/custom-dims-mets#overview
        'bool': true.toString(),
        'items': [_itemCreator()]
      },
    );
  }

  AnalyticsEventItem _itemCreator() {
    return AnalyticsEventItem(
      affiliation: 'affil',
      coupon: 'coup',
      creativeName: 'creativeName',
      creativeSlot: 'creativeSlot',
      discount: 2.22,
      index: 3,
      itemBrand: 'itemBrand',
      itemCategory: 'itemCategory',
      itemCategory2: 'itemCategory2',
      itemCategory3: 'itemCategory3',
      itemCategory4: 'itemCategory4',
      itemCategory5: 'itemCategory5',
      itemId: 'itemId',
      itemListId: 'itemListId',
      itemListName: 'itemListName',
      itemName: 'itemName',
      itemVariant: 'itemVariant',
      locationId: 'locationId',
      price: 9.99,
      currency: 'USD',
      promotionId: 'promotionId',
      promotionName: 'promotionName',
      quantity: 1,
    );
  }

  void _showiOSDownload(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: const Text('Use the iOS App'),
      duration: const Duration(days: 1),
      action: SnackBarAction(
        label: "Download",
        onPressed: () {
          // scaffold.hideCurrentSnackBar();
        },
      ),
    ));
  }

  void _showAndroidDownload(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: const Text('Use the Android App'),
      duration: const Duration(days: 1),
      action: SnackBarAction(
        label: "Download",
        onPressed: () {
          // scaffold.hideCurrentSnackBar();
        },
      ),
    ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final snackBar = SnackBar(
    //     content: const Text('Yay! A SnackBar!'),
    //     action: SnackBarAction(
    //       label: 'Undo',
    //       onPressed: () {
    //         // Some code to undo the change.
    //       },
    //     ),
    //   );
    //
    //   // Find the ScaffoldMessenger in the widget tree
    //   // and use it to show a SnackBar.
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // // if (kIsWeb) {
    //   if (Platform.isAndroid) {
    // _showAndroidDownload(context);
    // } else if (Platform.isIOS) {
    // //   _showiOSDownload(context);
    // }
    // // }
    // });

    List<BottomNavigationBarItem> barItems = [];
    for (var i = 0; i < _widgetOptions.length; i++) {
      var widgetItem = _widgetOptions[i];
      barItems.add(BottomNavigationBarItem(
        icon: Icon(widgetItem.icon()),
        label: widgetItem.title(),
        // selected: i == _selectedDrawerIndex,
        // onTap: () => _onSelectItem(i),
      ));
    }

    return WillPopScope(
      // Handle back button
      onWillPop: () async {
        // Default - exits app
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_widgetOptions[_selectedIndex].title()),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (item) {
                if (item == 0) {
                  _logOut();
                }
              },
              icon: const Icon(Icons.more_vert_rounded),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 0,
                    child: Text("Log Out"),
                  ),
                ];
              },
            )
          ],
        ),
        body: _widgetOptions[_selectedIndex] as StatefulWidget,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          items: barItems,
          // items: <BottomNavigationBarItem>[
          //   BottomNavigationBarItem(
          //     icon: Icon(Icons.home),
          //     label: _widgetOptions[_selectedIndex].title(),
          //   ),
          //   // BottomNavigationBarItem(
          //   //   icon: Icon(Icons.business),
          //   //   label: 'Business',
          //   // ),
          //   BottomNavigationBarItem(
          //     icon: Icon(Icons.person),
          //     label: _widgetOptions[_selectedIndex].title(),
          //   ),
          //   // BottomNavigationBarItem(
          //   //   icon: Icon(Icons.settings),
          //   //   label: 'Settings',
          //   // ),
          // ],
          currentIndex: _selectedIndex,
          // selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
