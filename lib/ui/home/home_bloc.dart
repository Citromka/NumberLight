import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:numbers_light/domain/model/number_light.dart';
import 'package:numbers_light/ui/home/home_event.dart';
import 'package:numbers_light/ui/home/home_state.dart';
import 'package:numbers_light/ui/home/model/number_light_presentation.dart';
import 'package:numbers_light/ui/home/model/number_light_selection_state.dart';
import 'package:numbers_light/ui/mapping/mapping.dart';
import 'package:numbers_light/ui/orientation/orientation_bloc.dart';
import 'package:numbers_light/ui/orientation/orientation_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final OrientationBloc _orientationBloc;
  late StreamSubscription _orientationSubscription;

  List<NumberLightPresentation> _numberLightsList = [];
  Orientation _orientation = Orientation.portrait;
  NumberLightPresentation? _selectedItem;

  HomeBloc(this._orientationBloc)
      : super(HomeInitialState()) {
    _orientationSubscription = _orientationBloc.stream.listen((OrientationState state) {
      if (state is OrientationSet && !isClosed) add(HomeOrientationEvent(state.orientation));
    });
    on<HomeCreated>(_handleHomeCreated);
    on<HomeItemStateChanged>(_handleHomeItemStateChanged);
    on<HomeOrientationEvent>(_handleHomeOrientationChanged);
    on<HomeReturnEvent>(_handleHomeReturn);
  }

  Future<void> _handleHomeCreated(
      HomeEvent event, Emitter<HomeState> emit) async {
    _numberLightsList = await Future.delayed(const Duration(seconds: 2), () {
      return _mockList
          .map((NumberLight e) => e.toNumberLightPresentation())
          .toList();
    });
    _yieldBasedOnCurrentState(emit);
  }

  Future<void> _handleHomeItemStateChanged(
      HomeItemStateChanged event, Emitter<HomeState> emit) async {
    final updatedList = _numberLightsList.copyWithResetState();
    final elementIndex = _numberLightsList.indexOf(event.item);
    if (elementIndex != -1) {
      updatedList[elementIndex] =
          updatedList[elementIndex].copyWith(state: event.state);
      _numberLightsList = updatedList;
      if (updatedList[elementIndex].state ==
          NumberLightSelectionState.selected) {
        _selectedItem = updatedList[elementIndex];
        emit(HomeItemSelectionUpdated(_selectedItem?.id, _orientation));
      } else if (updatedList[elementIndex].state == NumberLightSelectionState.focused) {
        if (_orientation == Orientation.landscape) {
          _selectedItem = updatedList[elementIndex];
          emit(HomeItemSelectionUpdated(_selectedItem?.id, _orientation));
        }
      }
      _yieldBasedOnCurrentState(emit);
    }
  }

  void _handleHomeReturn(HomeReturnEvent event, Emitter<HomeState> emit) {
    _clearSelection();
    _yieldBasedOnCurrentState(emit);
  }

  void _clearSelection() {
    final currentSelectedItem = _selectedItem;
    if (currentSelectedItem != null) {
      final index = _numberLightsList.indexOf(currentSelectedItem);
      _numberLightsList[index] = _numberLightsList[index].copyWith(state: NumberLightSelectionState.normal);
    }
    _selectedItem = null;
  }

  Future<void> _handleHomeOrientationChanged(
      HomeOrientationEvent event, Emitter<HomeState> emit) async {
    if (_orientation == Orientation.portrait &&
        event.orientation == Orientation.landscape) {
      _numberLightsList = _updateStatesForLandscape();
    } else if (_orientation == Orientation.landscape &&
        event.orientation == Orientation.portrait) {
      _numberLightsList = _updateStatesForPortrait();
    }
    _orientation = event.orientation;
    _selectedItem = _findSelectedItemBasedOnOrientation(_orientation);
    if (_selectedItem != null) emit(HomeItemSelectionUpdated(_selectedItem!.id, _orientation));
    _yieldBasedOnCurrentState(emit);
  }

  NumberLightPresentation? _findSelectedItemBasedOnOrientation(Orientation orientation) {
    final index = _numberLightsList.indexWhere((element) => element.state == _stateForOrientation(orientation));
    return (index != -1) ? _numberLightsList[index] : null;
  }

  NumberLightSelectionState _stateForOrientation(Orientation orientation) {
    switch(orientation) {
      case Orientation.portrait:
        return NumberLightSelectionState.selected;
      case Orientation.landscape:
        return NumberLightSelectionState.focused;
    }
  }

  List<NumberLightPresentation> _updateStatesForPortrait() {
    return _updateStatesForOrientation(Orientation.portrait);
  }

  List<NumberLightPresentation> _updateStatesForLandscape() {
    return _updateStatesForOrientation(Orientation.landscape);
  }

  List<NumberLightPresentation> _updateStatesForOrientation(
      Orientation nextOrientation) {
    final originalState = _stateForOrientation(_orientation);
    final targetState = _stateForOrientation(nextOrientation);
    List<NumberLightPresentation> updatedList = [];
    updatedList.addAll(_numberLightsList);
    for (var element in updatedList) {
      if (element.state == originalState) {
        updatedList[updatedList.indexOf(element)] = element.copyWith(state: targetState);
      }
    }
    return updatedList;
  }

  void _yieldBasedOnCurrentState(Emitter<HomeState> emit) {
    emit(HomeLoadedState(
      list: _numberLightsList,
      orientation: _orientation,
      selectedItem: _selectedItem,
    ));
  }

  final List<NumberLight> _mockList = const [
    NumberLight(
        id: "1",
        name: "1",
        image:
            "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000"),
    NumberLight(
        id: "2",
        name: "2",
        image:
            "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000"),
    NumberLight(
        id: "3",
        name: "3",
        image:
            "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000"),
    NumberLight(
        id: "4",
        name: "4",
        image:
            "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000"),
    NumberLight(
        id: "5",
        name: "5",
        image:
            "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000"),
    NumberLight(
        id: "6",
        name: "6",
        image:
            "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000age"),
  ];
}

extension on List<NumberLightPresentation> {
  List<NumberLightPresentation> copyWithResetState() {
    return map((element) {
      if (element.state != NumberLightSelectionState.normal) {
        return element.copyWith(state: NumberLightSelectionState.normal);
      } else {
        return element;
      }
    }).toList();
  }
}
