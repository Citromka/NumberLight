import 'package:flutter/material.dart';
import 'package:numbers_light/domain/model/base/error_type.dart';
import 'package:numbers_light/domain/model/number_light_detail.dart';

@immutable
abstract class DetailsState {
  bool isListenable() => false;
}

class DetailsInitialState extends DetailsState {}

class DetailsLoadingState extends DetailsState {}

class DetailsLoadedState extends DetailsState {
  final NumberLightDetail? item;

  DetailsLoadedState(this.item);
}

class DetailsErrorState extends DetailsState {
  final ErrorType? errorType;

  DetailsErrorState({this.errorType});
}

abstract class DetailsListenableState extends DetailsState {
  @override
  bool isListenable() => true;
}

class DetailsNavigateBack extends DetailsListenableState {}