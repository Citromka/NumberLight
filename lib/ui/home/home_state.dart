import 'package:flutter/cupertino.dart';
import 'package:numbers_light/ui/home/model/number_light_presentation.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {
  bool isListenable() => false;
}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<NumberLightPresentation> list;
  final Orientation orientation;
  final NumberLightPresentation? selectedItem;

  HomeLoadedState({
    required this.list,
    required this.orientation,
    required this.selectedItem,
  });
}

abstract class HomeListenableState extends HomeState {
  bool isListenable() => true;
}

class HomeItemSelectionUpdated extends HomeListenableState {
  final String? selectedItemId;
  final Orientation orientation;

  HomeItemSelectionUpdated(this.selectedItemId, this.orientation);
}
