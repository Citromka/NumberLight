import 'package:flutter/material.dart';
import 'package:numbers_light/ui/details/details_screen.dart';

class DetailsRoute {
  static const details = "/details";

  Map<String, WidgetBuilder> get routes =>
      {
        details: (context) => const DetailsScreen()
      };
}