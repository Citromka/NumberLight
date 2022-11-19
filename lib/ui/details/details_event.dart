import 'package:flutter/material.dart';

abstract class DetailsEvent {}

class DetailsSelected extends DetailsEvent {
  final String? selectedItemId;

  DetailsSelected(this.selectedItemId);
}

class DetailsOrientationEvent extends DetailsEvent {
  final Orientation orientation;

  DetailsOrientationEvent(this.orientation);
}