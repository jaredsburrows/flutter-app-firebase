import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

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

        if (snapshot.connectionState == ConnectionState.waiting) {
          // handle loading
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          // User is not signed in
          return SignInScreen(
            // sideBuilder: (context, constraints) {
            //   return Padding(
            //     padding: const EdgeInsets.all(20),
            //     child: AspectRatio(
            //       aspectRatio: 1,
            //       // https://toppng.com/free-image/our-specialists-are-using-technology-to-further-enhance-scan-qr-code-logo-PNG-free-PNG-Images_228323
            //       child: Image.network(
            //         'https://i.imgur.com/eg3nl4X.png',
            //       ),
            //     ),
            //   );
            // },
            // headerBuilder: (context, constraints, _) {
            //   return Padding(
            //     padding: const EdgeInsets.all(20),
            //     child: AspectRatio(
            //       aspectRatio: 1,
            //       // https://toppng.com/free-image/our-specialists-are-using-technology-to-further-enhance-scan-qr-code-logo-PNG-free-PNG-Images_228323
            //       child: Image.network(
            //         'https://i.imgur.com/eg3nl4X.png',
            //       ),
            //     ),
            //   );
            // },
            // subtitleBuilder: (context, action) {
            //   return Padding(
            //     padding: const EdgeInsets.only(bottom: 8),
            //     child: Text(
            //       action == AuthAction.signIn
            //           ? 'Welcome to FlutterFire UI! Please sign in to continue.'
            //           : 'Welcome to FlutterFire UI! Please create an account to continue',
            //     ),
            //   );
            // },
            // footerBuilder: (context, _) {
            //   return const Padding(
            //     padding: EdgeInsets.only(top: 16),
            //     child: Text(
            //       'By signing in, you agree to our terms and conditions.',
            //       style: TextStyle(color: Colors.grey),
            //     ),
            //   );
            // },
            providerConfigs: const [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                clientId:
                    '587316204204-nd366c60ua78m8lk6a6geuuoee2ru6gr.apps.googleusercontent.com',
              ),
              PhoneProviderConfiguration(),
            ],
          );
        } else if (snapshot.hasError) {
          // handle error (note: snapshot.error has type [Object?])
          final error = snapshot.error!;
          return Text(error.toString());
        }

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
