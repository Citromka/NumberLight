import 'package:flutter/cupertino.dart';
import 'package:numbers_light/ui/home/model/number_light_presentation.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<NumberLightPresentation> list;

  HomeLoadedState(this.list);
}

