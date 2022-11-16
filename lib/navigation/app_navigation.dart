import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:numbers_light/ui/home/navigation/home_route.dart';

@singleton
class AppNavigation {
  static const String initialRoute = HomeRoute.home;
  
  Map<String, WidgetBuilder> get routes => {}
      ..addAll(HomeRoute().routes);
}