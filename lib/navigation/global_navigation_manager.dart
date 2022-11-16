import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:numbers_light/ui/details/navigation/details_route.dart';
import 'package:numbers_light/ui/home/navigation/home_route.dart';

@singleton
class GlobalNavigationManager {
  GlobalKey<NavigatorState>? _navigatorKey;

  void setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  BuildContext? get navigatorContext => _navigatorKey?.currentContext;

  void popUntilHome() {
    return _navigatorKey?.currentState?.popUntil((route) => route.settings.name == HomeRoute.home);
  }

  void pushDetails(String itemId) {
    _navigatorKey?.currentState?.pushNamed(DetailsRoute.details, arguments: itemId);
  }
}