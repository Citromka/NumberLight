import 'package:flutter/material.dart';
import 'package:numbers_light/domain/model/number_light.dart';

@immutable
abstract class DetailsState {
  bool isListenable() => false;
}

class DetailsInitialState extends DetailsState {}

class DetailsLoadingState extends DetailsState {}

class DetailsLoadedState extends DetailsState {
  final NumberLight? item;

  DetailsLoadedState(this.item);
}

class DetailsErrorState extends DetailsState {}

abstract class DetailsListenableState extends DetailsState {
  @override
  bool isListenable() => true;
}

class DetailsNavigateBack extends DetailsListenableState {}