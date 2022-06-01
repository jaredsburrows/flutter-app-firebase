import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({
    Key? key,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // Set user id
        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid != null) {
          FirebaseAnalytics.instance.setUserId(id: uid);
        }

        // User is not signed in
        if (!snapshot.hasData) {}

        // Render your application if authenticated
        return HomePage(
          title: 'Home Page',
          analytics: analytics,
          observer: observer,
        );
      },
    );
  }
}
