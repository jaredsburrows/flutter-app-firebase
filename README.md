# Flutter + Firebase

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![build](https://github.com/jaredsburrows/flutter-app-firebase/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/jaredsburrows/flutter-app-firebase/actions/workflows/build.yml)
[![Twitter Follow](https://img.shields.io/twitter/follow/jaredsburrows.svg?style=social)](https://twitter.com/jaredsburrows)

## Features + Plugins

| Feature | Description |
| -- | ------------- |
| Home Page | Landing page, basic template example with floating action button |
| Light/Dark Mode | Light and Dark themes |
| Profile Page | Basic profile page |

| Plugin | Description |
| -- | ------------- |
| [firebase_analytics](https://pub.dev/packages/firebase_analytics) | `flutter pub add firebase_analytics` |
| [firebase_auth](https://pub.dev/packages/firebase_auth) | `flutter pub add firebase_auth` |
| [firebase_core](https://pub.dev/packages/firebase_core) | `flutter pub add firebase_core` |
| [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics) | `flutter pub add firebase_crashlytics` |
| [firebase_performance](https://pub.dev/packages/firebase_performance) | `flutter pub add firebase_performance` |
| [flutterfire_ui](https://pub.dev/packages/flutterfire_ui) | `flutter pub add flutterfire_ui` |
| [url_strategy](https://pub.dev/packages/url_strategy) | `flutter pub add url_strategy` |

## Setup

**Flutter**

```shell
rm pubspec.lock
rm ios/Podfile.lock
flutter upgrade
flutter pub get
flutter pub upgrade
```

**Build All**

```shell
flutter build apk --debug
flutter build ios --debug --no-codesign
flutter build web
```

## Build the Android app

**Debug**

```shell
flutter build apk --debug
```

**Release APK**

```shell
flutter build apk --release --obfuscate --split-debug-info build/app/outputs/symbols-apk/ --target-platform android-arm64
```

**Release Bundle**

```shell
flutter build appbundle --release --obfuscate --split-debug-info build/app/outputs/symbols-appbundle --target-platform android-arm64
```

## Build the iOS app

**Debug**

```shell
flutter build ios --debug --no-codesign
```

**Release**

```shell
flutter build ios --release --obfuscate --split-debug-info build/ios/outputs/symbols
```

## Build the Web app

**Debug/Release**

```shell
flutter build web
```

## Testing

**Run unit tests with coverage**

```shell
flutter test --coverage
```

## Reports

**Run analyzer**

```shell
flutter analyze
```

## Local Debug Run

```shell
rm -f ios/Podfile.lock && \
rm -f pubspec.lock && \
flutter clean && \
flutter upgrade && \
flutter pub get && \
flutter pub upgrade --major-versions && \

osv-scanner -r . && \

dart fix --dry-run && \
dart fix --apply && \
dart format . && \

flutter analyze && \

flutter build web && \
flutter build ios --debug --no-codesign && \
flutter build apk --debug
```

## License

```
Copyright (C) 2022 Jared Burrows

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
