import 'package:flutter/material.dart';

@immutable
abstract class OrientationState {}

class OrientationInitial extends OrientationState {}

class OrientationSet extends OrientationState {
  final Orientation orientation;

  OrientationSet(this.orientation);
}