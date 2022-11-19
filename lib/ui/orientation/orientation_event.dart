import 'package:flutter/material.dart';

abstract class OrientationEvent {}

class OrientationChanged extends OrientationEvent {
  final Orientation orientation;

  OrientationChanged(this.orientation);
}