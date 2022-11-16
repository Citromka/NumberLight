import 'package:numbers_light/ui/home/model/number_light_presentation.dart';
import 'package:numbers_light/ui/home/model/number_light_selection_state.dart';

abstract class HomeEvent {}

class HomeCreated extends HomeEvent {}

class HomeItemStateChanged extends HomeEvent {
  final NumberLightPresentation item;
  final NumberLightSelectionState state;

  HomeItemStateChanged({required this.item, required this.state});
}