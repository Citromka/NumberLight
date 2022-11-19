import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:numbers_light/ui/orientation/orientation_event.dart';
import 'package:numbers_light/ui/orientation/orientation_state.dart';

@singleton
class OrientationBloc extends Bloc<OrientationEvent, OrientationState> {
  OrientationBloc() : super(OrientationInitial()) {
    on<OrientationChanged>(_handleOrientationChanged);
  }

  Future<void> _handleOrientationChanged(OrientationChanged event, Emitter<OrientationState> emit) async {
    emit(OrientationSet(event.orientation));
  }
}