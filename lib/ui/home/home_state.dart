import 'package:flutter/cupertino.dart';
import 'package:numbers_light/domain/model/base/error_type.dart';
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
  final ErrorType? errorType;

  HomeLoadedState({
    required this.list,
    required this.errorType,
    required this.orientation,
    required this.selectedItem,
  });
}

abstract class HomeListenableState extends HomeState {
  bool isListenable() => true;
}

class HomeItemSelectionUpdated extends HomeListenableState {
  final String? selectedItemName;
  final Orientation orientation;

  HomeItemSelectionUpdated(this.selectedItemName, this.orientation);
}
