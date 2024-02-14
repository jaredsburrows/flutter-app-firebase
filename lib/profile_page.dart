import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/page_info.dart';

/// Displayed as a profile image if the user doesn't have one.
const placeholderImage =
    'https://upload.wikimedia.org/wikipedia/commons/c/cd/Portrait_Placeholder_Square.png';

class ProfilePage extends StatefulWidget implements PageInfo {
  const ProfilePage({
    super.key,
    required this.analytics,
    required this.observer,
  });

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  String title() => "Profile";

  @override
  IconData icon() => Icons.person;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  late TextEditingController controller;

  String? photoURL;

  bool showSaveButton = false;
  bool isLoading = false;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    controller = TextEditingController(text: user.displayName);
    controller.addListener(_onDisplayNameChanged);

    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_onDisplayNameChanged);

    super.dispose();
  }

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void _onDisplayNameChanged() {
    setState(() {
      if (controller.text == user.displayName || controller.text.isEmpty) {
        showSaveButton = false;
      } else {
        showSaveButton = true;
      }
    });
  }

  Future _updateDisplayName() async {
    await user.updateDisplayName(controller.text);

    setState(() {
      showSaveButton = false;
    });
  }

  /// Map User provider data into a list of Provider Ids.
  List get userProviders => user.providerData.map((e) => e.providerId).toList();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          maxRadius: 60,
                          backgroundImage: NetworkImage(
                            user.photoURL ?? placeholderImage,
                          ),
                        ),
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          end: 0,
                          bottom: 0,
                          child: Material(
                            clipBehavior: Clip.antiAlias,
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(40),
                            child: InkWell(
                              onTap: () async {
                                final photoURL = await getPhotoURLFromUser();

                                if (photoURL != null) {
                                  await user.updatePhotoURL(photoURL);
                                }
                              },
                              radius: 50,
                              child: const SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(Icons.edit),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        alignLabelWithHint: true,
                        label: Center(
                          child: Text(
                            'Click to add a display name',
                          ),
                        ),
                      ),
                    ),
                    Text(user.email ?? user.phoneNumber ?? 'User'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (userProviders.contains('phone'))
                          const Icon(Icons.phone),
                        if (userProviders.contains('password'))
                          const Icon(Icons.mail),
                        if (userProviders.contains('google.com'))
                          SizedBox(
                            width: 24,
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/0/09/IOS_Google_icon.png',
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              end: 40,
              top: 40,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: !showSaveButton
                    ? SizedBox(key: UniqueKey())
                    : TextButton(
                        onPressed: isLoading ? null : _updateDisplayName,
                        child: const Text('Save changes'),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> getPhotoURLFromUser() async {
    String? photoURL;

    // Update the UI - wait for the user to enter the SMS code
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('New image Url:'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
            OutlinedButton(
              onPressed: () {
                photoURL = null;
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
          content: Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: (value) {
                photoURL = value;
              },
              textAlign: TextAlign.center,
              autofocus: true,
            ),
          ),
        );
      },
    );

    return photoURL;
  }
}
