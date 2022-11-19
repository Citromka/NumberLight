import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:numbers_light/domain/model/number_light.dart';
import 'package:numbers_light/ui/details/details_event.dart';
import 'package:numbers_light/ui/details/details_state.dart';
import 'package:numbers_light/ui/orientation/orientation_bloc.dart';
import 'package:numbers_light/ui/orientation/orientation_state.dart';

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final OrientationBloc _orientationBloc;

  NumberLight? _item;
  late StreamSubscription _orientationSubscription;

  DetailsBloc(this._orientationBloc) : super(DetailsInitialState()) {
    _orientationSubscription = _orientationBloc.stream.listen((OrientationState state) {
      if (state is OrientationSet && !isClosed) add(DetailsOrientationEvent(state.orientation));
    });
    on<DetailsSelected>(_handleDetailsSelected);
    on<DetailsOrientationEvent>(_handleDetailsOrientation);
  }

  void dispose() {
    _orientationSubscription.cancel();
  }

  Future<void> _handleDetailsSelected(
      DetailsSelected event, Emitter<DetailsState> emit) async {
    if (event.selectedItemId == null) {
      _yieldBasedOnCurrentState(emit);
    } else {
      final index =
      _mockList.indexWhere((element) => element.id == event.selectedItemId);
      _item = (index != -1) ? _mockList[index] : null;
      _item != null ? _yieldBasedOnCurrentState(emit) : emit(DetailsErrorState());
    }
  }

  Future<void> _handleDetailsOrientation(
      DetailsOrientationEvent event, Emitter<DetailsState> emit) async {
    if (event.orientation == Orientation.landscape) {
      emit(DetailsNavigateBack());
    }
  }

  void _yieldBasedOnCurrentState(Emitter<DetailsState> emit) {
    emit(DetailsLoadedState(_item));
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
