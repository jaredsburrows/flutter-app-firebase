# Flutter + Firebase

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![build](https://github.com/jaredsburrows/flutter-app-firebase/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/jaredsburrows/flutter-app-firebase/actions/workflows/build.yml)
[![Twitter Follow](https://img.shields.io/twitter/follow/jaredsburrows.svg?style=social)](https://twitter.com/jaredsburrows)

## Features + Plugins

| Feature | Description |
| -- | ------------- |
| Dark Mode | Light and Dark themes |

| Plugin | Description |
| -- | ------------- |
| [firebase_core](https://pub.dev/packages/firebase_core) | `fvm flutter pub add firebase_core` |
| [url_strategy](https://pub.dev/packages/url_strategy) | `fvm flutter pub add url_strategy` |

## Setup Flutter

**Flutter**

```shell
brew tap leoafarias/fvm
brew install fvm

fvm use beta

fvm flutter upgrade
fvm flutter pub get
fvm flutter pub upgrade --null-safety
```

## Build the Android app

**Debug**

```shell
fvm flutter build apk --debug
```

**Release APK**

```shell
fvm flutter build apk --release --obfuscate --split-debug-info build/app/outputs/symbols-apk/ --target-platform android-arm64
```

**Release Bundle**

```shell
fvm flutter build appbundle --release --obfuscate --split-debug-info build/app/outputs/symbols-appbundle --target-platform android-arm64
```

## Build the iOS app

**Debug**

```shell
fvm flutter build ios --debug --no-codesign
```

**Release**

```shell
fvm flutter build ios --release --obfuscate --split-debug-info build/ios/outputs/symbols
```

## Build the Web app

**Debug/Release**

```shell
fvm flutter build web
```

## Testing

**Run unit tests with coverage**

```shell
fvm flutter test --coverage
```

## Reports

**Run analyzer**

```shell
fvm flutter analyze
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
