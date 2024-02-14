import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'page_info.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.analytics,
    required this.observer,
  });

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin, RouteAware {
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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

    // ignore: deprecated_member_use
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
