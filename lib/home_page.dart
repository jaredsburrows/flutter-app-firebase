import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/page_info.dart';

class HomePage extends StatefulWidget implements PageInfo {
  const HomePage({
    Key? key,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  String title() => "Home";

  @override
  IconData icon() => Icons.home;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RouteAware {
  int _counter = 0;

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

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });

    _sendAnalyticsEvent(_counter);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
