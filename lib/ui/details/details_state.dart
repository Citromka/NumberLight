import 'package:flutter/material.dart';
import 'package:numbers_light/domain/model/number_light.dart';

@immutable
abstract class DetailsState {}

class DetailsLoadingState extends DetailsState {}

class DetailsLoadedState extends DetailsState {
  final NumberLight? item;

  DetailsLoadedState(this.item);
}