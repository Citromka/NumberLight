import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:numbers_light/domain/model/number_light.dart';
import 'package:numbers_light/ui/details/details_event.dart';
import 'package:numbers_light/ui/details/details_state.dart';

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  NumberLight? _item;

  DetailsBloc(): super(DetailsLoadingState()) {
    on<DetailsCreated>(_handleDetailsCreated);
  }

  Future<void> _handleDetailsCreated(DetailsCreated event, Emitter<DetailsState> emit) async {
    _item = _mockList.firstWhere((element) => element.id == event.selectedItemId);
    _yieldBasedOnCurrentState(emit);
  }

  void _yieldBasedOnCurrentState(Emitter<DetailsState> emit) {
    emit(DetailsLoadedState(_item));
  }

  final List<NumberLight> _mockList = const [
    NumberLight(id: "1", name: "1", image: "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000"),
    NumberLight(id: "2", name: "2", image: "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000"),
    NumberLight(id: "3", name: "3", image: "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000"),
    NumberLight(id: "4", name: "4", image: "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000"),
    NumberLight(id: "5", name: "5", image: "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000"),
    NumberLight(id: "6", name: "6", image: "https://img.freepik.com/free-vector/counting-numbers-with-fruits_1308-72157.jpg?w=2000age"),
  ];
}