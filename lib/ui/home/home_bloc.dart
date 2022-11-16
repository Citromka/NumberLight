import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:numbers_light/domain/model/number_light.dart';
import 'package:numbers_light/navigation/global_navigation_manager.dart';
import 'package:numbers_light/ui/home/home_event.dart';
import 'package:numbers_light/ui/home/home_state.dart';
import 'package:numbers_light/ui/home/model/number_light_presentation.dart';
import 'package:numbers_light/ui/home/model/number_light_selection_state.dart';
import 'package:numbers_light/ui/mapping/mapping.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GlobalNavigationManager _navigatorManager;
  List<NumberLightPresentation> _numberLightsList = [];

  HomeBloc(this._navigatorManager): super(HomeInitialState()) {
    on<HomeCreated>(_handleHomeCreated);
    on<HomeItemStateChanged>(_handleHomeItemStateChanged);
  }

  Future<void> _handleHomeCreated(HomeEvent event, Emitter<HomeState> emit) async {
    _numberLightsList = await Future.delayed(const Duration(seconds: 2), () {
      return _mockList.map((NumberLight e) => e.toNumberLightPresentation()).toList();
    });
    _yieldBasedOnCurrentState(emit);
  }

  Future<void> _handleHomeItemStateChanged(HomeItemStateChanged event, Emitter<HomeState> emit) async {
    final updatedList = _numberLightsList.map((element) {
      if (element.state == event.state) {
        return element.copyWith(state: NumberLightSelectionState.normal);
      } else  {
        return element;
      }
    }).toList();
    final elementIndex = _numberLightsList.indexOf(event.item);
    if (elementIndex != -1) {
      updatedList[elementIndex] = updatedList[elementIndex].copyWith(state: event.state);
      _numberLightsList = updatedList;
      _yieldBasedOnCurrentState(emit);
      if (updatedList[elementIndex].state == NumberLightSelectionState.selected) {
        _navigatorManager.pushDetails(updatedList[elementIndex].id);
      }
    }
  }

  void _yieldBasedOnCurrentState(Emitter<HomeState> emit) {
    emit(HomeLoadedState(_numberLightsList));
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