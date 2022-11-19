import 'package:flutter/material.dart';

abstract class DetailsEvent {}

class DetailsSelectedEvent extends DetailsEvent {
  final String? selectedItemName;

  DetailsSelectedEvent(this.selectedItemName);
}

class DetailsOrientationEvent extends DetailsEvent {
  final Orientation orientation;

  DetailsOrientationEvent(this.orientation);
}

class DetailsRefreshedEvent extends DetailsEvent {}