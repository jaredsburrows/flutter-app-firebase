import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'auth_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Firebase',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: AuthGate(
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}
