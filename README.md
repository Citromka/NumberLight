# numbers_light

A Flutter project with basic list and details screens.

## Getting Started

**Step 1:**

Download or clone this repo.

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

**Step 3:**

This project uses libraries that work with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

**Step 4:**

You can run the app with an open ios simulator or android emulator with:

```
flutter run
```

Or you can open the project with Android Studio and use green play button to run the main.dart.

## Run tests

You can run the unit and the golden tests with the following terminal command:

```
flutter test
```

And you can update the golden tests with:

```
flutter test --update-goldens
```

## Libraries & Tools Used

* [Dio](https://github.com/flutterchina/dio)
* [Logging](https://pub.dev/packages/dio_logging_interceptor)
* [Dependency Injection](https://github.com/fluttercommunity/get_it)
* [Dependency Injection](https://pub.dev/packages/injectable)
* [Serialization](https://pub.dev/packages/json_annotation)
* [Data classes](https://pub.dev/packages/freezed)
* [Image](https://pub.dev/packages/cached_network_image)
* [Caching](https://pub.dev/packages/flutter_cache_manager)
* [Bloc](https://pub.dev/packages/bloc)
* [Bloc](https://pub.dev/packages/flutter_bloc)
* [Testing](https://pub.dev/packages/bloc_test)
* [Testing](https://pub.dev/packages/mockito)
* [Testing](https://pub.dev/packages/golden_toolkit)