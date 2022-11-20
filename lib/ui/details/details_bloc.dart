import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:numbers_light/domain/model/base/domain_response.dart';
import 'package:numbers_light/domain/model/base/error_type.dart';
import 'package:numbers_light/domain/model/number_light_detail.dart';
import 'package:numbers_light/domain/use_case/get_detail_use_case.dart';
import 'package:numbers_light/ui/details/details_event.dart';
import 'package:numbers_light/ui/details/details_state.dart';
import 'package:numbers_light/ui/orientation/orientation_bloc.dart';
import 'package:numbers_light/ui/orientation/orientation_state.dart';

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final OrientationBloc _orientationBloc;
  final GetDetailUseCase _detailUseCase;

  String? _selectedItemName;
  NumberLightDetail? _item;
  late StreamSubscription _orientationSubscription;
  ErrorType? _errorType;

  DetailsBloc(
    this._orientationBloc,
    this._detailUseCase,
  ) : super(DetailsInitialState()) {
    _orientationSubscription =
        _orientationBloc.stream.listen((OrientationState state) {
      if (state is OrientationSet && !isClosed) {
        add(DetailsOrientationEvent(state.orientation));
      }
    });
    on<DetailsSelectedEvent>(_handleDetailsSelected);
    on<DetailsOrientationEvent>(_handleDetailsOrientation);
    on<DetailsRefreshedEvent>(_handleDetailsRefreshed);
  }

  void dispose() {
    _orientationSubscription.cancel();
  }

  Future<void> _handleDetailsSelected(
      DetailsSelectedEvent event, Emitter<DetailsState> emit) async {
    _selectedItemName = event.selectedItemName;
    await _loadData(emit);
  }

  Future<void> _loadData(Emitter<DetailsState> emit) async {
    final name = _selectedItemName;
    emit(DetailsLoadingState());
    if (name == null) {
      _yieldBasedOnCurrentState(emit);
    } else {
      final response = await _detailUseCase.execute(name);
      if (response is DomainResult) {
        _item = response.data as NumberLightDetail?;
      } else {
        _errorType = (response as DomainError).errorType;
      }
      _item != null
          ? _yieldBasedOnCurrentState(emit)
          : emit(DetailsErrorState(errorType: _errorType));
    }
  }

  Future<void> _handleDetailsOrientation(
      DetailsOrientationEvent event, Emitter<DetailsState> emit) async {
    if (event.orientation == Orientation.landscape) {
      emit(DetailsNavigateBack());
    }
  }

  Future<void> _handleDetailsRefreshed(
      DetailsRefreshedEvent event, Emitter<DetailsState> emit) async {
    await _loadData(emit);
  }

  void _yieldBasedOnCurrentState(Emitter<DetailsState> emit) {
    emit(DetailsLoadedState(_item));
  }
}
